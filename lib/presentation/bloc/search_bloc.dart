import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:string_search_app/domain/usercases/search_products.dart';
import 'package:string_search_app/domain/usercases/search_users.dart';
import 'package:string_search_app/presentation/bloc/search_event.dart';
import 'package:string_search_app/presentation/bloc/search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsers searchUsers;
  final SearchProducts searchProducts;

  SearchBloc(this.searchUsers, this.searchProducts) : super(const SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      await event.map(
        search: (searchEvent) => _onSearch(searchEvent, emit),
        switchType: (switchEvent) => _onSwitchType(switchEvent, emit),
      );
    });
  }

  Future<void> _onSearch(Search searchEvent, Emitter<SearchState> emit) async {
    final type = searchEvent.type ?? (state is LoadedUsers ? 'users' : 'products');
    emit(SearchState.loading(type: type));
    try {
      if (type == 'users') {
        final users = await searchUsers.call(searchEvent.pattern);
        emit(SearchState.loadedUsers(users, type: type));
      } else {
        final products = await searchProducts.call(searchEvent.pattern);
        emit(SearchState.loadedProducts(products, type: type));
      }
    } catch (e) {
      emit(SearchState.error(e.toString(), type: type));
    }
  }

  Future<void> _onSwitchType(SwitchType switchEvent, Emitter<SearchState> emit) async {
    emit(SearchState.initial(type: switchEvent.type));
  }
}
