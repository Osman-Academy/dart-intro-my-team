import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_event.freezed.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.search(String pattern, {String? type}) = Search;
  const factory SearchEvent.switchType(String type) = SwitchType;
}
