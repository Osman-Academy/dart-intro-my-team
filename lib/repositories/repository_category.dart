import 'package:book_finder/models/category/category.dart';

abstract class RepositoryCategory {
  List<Category> getAll();
  Category? getById(String id);
  void add(String name);
  void delete(String id);
  void addBookToCategory(String bookId, String categoryId);
  void removeBookFromCategory(String bookId, String categoryId);
  List<Category> getCategoriesForBook(String bookId);
}