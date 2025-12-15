// Presentation - User Event
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.loadUsers() = LoadUsersEvent;
  const factory UserEvent.searchUsers(String query) = SearchUsersEvent;
  const factory UserEvent.refreshUsers() = RefreshUsersEvent;
}
