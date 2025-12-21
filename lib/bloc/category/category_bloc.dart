import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/bloc/category/category_event.dart';
import 'package:book_finder/bloc/category/category_state.dart';
import 'package:book_finder/common/di/service_locator.dart';
import 'package:book_finder/usecases/category_usecase.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUsecase usecase = sl<CategoryUsecase>();

  CategoryBloc() : super(CategoryStateInitial()) {
    on<CategoryLoadEvent>((event, emit) {
      try {
        var categories = usecase.getAllCategories();
        emit(CategoryStateLoaded(categories: categories));
      } catch (e) {
        emit(CategoryStateError(message: "Failed to load categories: $e"));
      }
    });

    on<CategoryCreateEvent>((event, emit) {
      try {
        usecase.createCategory(event.dto);
        var categories = usecase.getAllCategories();
        emit(CategoryStateLoaded(categories: categories));
      } catch (e) {
        emit(CategoryStateError(message: "Failed to create category: $e"));
      }
    });

    on<CategoryDeleteEvent>((event, emit) {
      try {
        usecase.deleteCategory(event.dto);
        var categories = usecase.getAllCategories();
        emit(CategoryStateLoaded(categories: categories));
      } catch (e) {
        emit(CategoryStateError(message: "Failed to delete category: $e"));
      }
    });

    on<CategoryAddBookEvent>((event, emit) {
      try {
        usecase.addBookToCategory(event.dto);
        var categories = usecase.getAllCategories();
        emit(CategoryStateLoaded(categories: categories));
      } catch (e) {
        emit(CategoryStateError(message: "Failed to add book to category: $e"));
      }
    });

    on<CategoryRemoveBookEvent>((event, emit) {
      try {
        usecase.removeBookFromCategory(event.dto);
        var categories = usecase.getAllCategories();
        emit(CategoryStateLoaded(categories: categories));
      } catch (e) {
        emit(CategoryStateError(message: "Failed to remove book from category: $e"));
      }
    });
  }
}