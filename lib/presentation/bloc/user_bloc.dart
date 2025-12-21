import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/user.dart';
import '../../data/user_repository.dart';

part 'user_bloc.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.loadUsers() = _LoadUsers;
  const factory UserEvent.search(String query) = _Search;
}

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(List<User> users) = _Loaded;
  const factory UserState.error(String message) = _Error;
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  late List<User> _allUsers;

  UserBloc(this.repository) : super(const UserState.initial()) {
    on<_LoadUsers>(_onLoadUsers);
    on<_Search>(_onSearch);
  }

  Future<void> _onLoadUsers(_LoadUsers event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    try {
      final users = await repository.getUsers();
      _allUsers = users;
      emit(UserState.loaded(users));
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  void _onSearch(_Search event, Emitter<UserState> emit) {
    final query = event.query.toLowerCase();
    final filtered = _allUsers
        .where((user) => user.name.toLowerCase().contains(query))
        .toList();
    emit(UserState.loaded(filtered));
  }
}
