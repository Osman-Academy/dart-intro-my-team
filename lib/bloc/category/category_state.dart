import 'package:book_finder/models/category/category.dart';

abstract class CategoryState {}

class CategoryStateInitial implements CategoryState {}

class CategoryStateLoading implements CategoryState {}

class CategoryStateLoaded implements CategoryState {
  final List<Category> categories;
  CategoryStateLoaded({required this.categories});
}

class CategoryStateError implements CategoryState {
  final String message;
  CategoryStateError({required this.message});
}