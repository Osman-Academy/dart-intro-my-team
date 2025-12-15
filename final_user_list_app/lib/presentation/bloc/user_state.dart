// Presentation - User State
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded({
    required List<User> users,
    required List<User> filteredUsers,
    @Default('') String searchQuery,
  }) = UserLoaded;
  const factory UserState.error(String message) = UserError;
}
