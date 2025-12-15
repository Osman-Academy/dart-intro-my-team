// Presentation - User BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc(this.getUsers) : super(const UserState.initial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<SearchUsersEvent>(_onSearchUsers);
    on<RefreshUsersEvent>(_onRefreshUsers);
  }

  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());

    final result = await getUsers();

    result.fold(
      (failure) => emit(UserState.error(_mapFailureToMessage(failure))),
      (users) => emit(UserState.loaded(
        users: users,
        filteredUsers: users,
        searchQuery: '',
      )),
    );
  }

  Future<void> _onSearchUsers(
    SearchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    state.mapOrNull(
      loaded: (loadedState) {
        final query = event.query.toLowerCase();
        
        if (query.isEmpty) {
          emit(loadedState.copyWith(
            filteredUsers: loadedState.users,
            searchQuery: '',
          ));
        } else {
          final filtered = loadedState.users.where((user) {
            return user.name.toLowerCase().contains(query) ||
                user.email.toLowerCase().contains(query) ||
                user.username.toLowerCase().contains(query) ||
                user.phone.contains(query);
          }).toList();

          emit(loadedState.copyWith(
            filteredUsers: filtered,
            searchQuery: query,
          ));
        }
      },
    );
  }

  Future<void> _onRefreshUsers(
    RefreshUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    // Keep the current state while refreshing
    final currentState = state;
    
    final result = await getUsers();

    result.fold(
      (failure) {
        // If refresh fails, keep the current state and show a message
        // In a real app, you might want to show a snackbar here
        if (currentState is UserLoaded) {
          emit(currentState);
        } else {
          emit(UserState.error(_mapFailureToMessage(failure)));
        }
      },
      (users) {
        // Apply the current search query to the new data
        if (currentState is UserLoaded && currentState.searchQuery.isNotEmpty) {
          final query = currentState.searchQuery;
          final filtered = users.where((user) {
            return user.name.toLowerCase().contains(query) ||
                user.email.toLowerCase().contains(query) ||
                user.username.toLowerCase().contains(query) ||
                user.phone.contains(query);
          }).toList();

          emit(UserState.loaded(
            users: users,
            filteredUsers: filtered,
            searchQuery: query,
          ));
        } else {
          emit(UserState.loaded(
            users: users,
            filteredUsers: users,
            searchQuery: '',
          ));
        }
      },
    );
  }

  String _mapFailureToMessage(failure) {
    return failure.when(
      serverFailure: (message) => 'Server Error: $message',
      networkFailure: (message) => 'Network Error: $message',
      cacheFailure: (message) => 'Cache Error: $message',
    );
  }
}
