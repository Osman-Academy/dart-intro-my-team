import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:string_search_app/domain/entities/product.dart';
import 'package:string_search_app/domain/entities/user.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial({@Default('users') String type}) = Initial;
  const factory SearchState.loading({@Default('users') String type}) = Loading;
  const factory SearchState.loadedUsers(List<User> users, {@Default('users') String type}) = LoadedUsers;
  const factory SearchState.loadedProducts(List<Product> products, {@Default('products') String type}) = LoadedProducts;
  const factory SearchState.error(String message, {@Default('users') String type}) = Error;
}
