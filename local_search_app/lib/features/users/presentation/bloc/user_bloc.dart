import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';

part 'user_bloc.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.load() = LoadUsers;
  const factory UserEvent.search(String query) = SearchUsers;
}

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.loaded(List<User> users) = Loaded;
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;

  late List<User> _allUsers;

  UserBloc(this.getUsersUseCase) : super(const Initial()) {
    on<LoadUsers>((event, emit) {
      _allUsers = getUsersUseCase();
      emit(Loaded(_allUsers));
    });

    on<SearchUsers>((event, emit) {
      final filtered = _allUsers
          .where((u) =>
              u.name.toLowerCase().contains(event.query.toLowerCase()) ||
              u.email.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(Loaded(filtered));
    });
  }
}
