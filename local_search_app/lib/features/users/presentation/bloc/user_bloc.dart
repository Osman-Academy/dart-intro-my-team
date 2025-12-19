import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SearchUsersUseCase searchUsers;

  UserBloc(this.searchUsers) : super(const UserState()) {
    on<UserEvent>((event, emit) {
      event.when(
        search: (query) {
          final result = searchUsers(query);
          emit(state.copyWith(users: result));
        },
      );
    });
  }
}
