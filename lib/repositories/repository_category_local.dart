import 'package:book_finder/models/category/category.dart';
import 'package:book_finder/repositories/repository_category.dart';

class RepositoryCategoryLocal implements RepositoryCategory {
  List<Category> _categories = [
    Category(id: "1", name: "Want to Read", isDefault: true),
    Category(id: "2", name: "Currently Reading", isDefault: true),
    Category(id: "3", name: "Finished", isDefault: true),
  ];
  int _categoryIdCounter = 4;

  @override
  List<Category> getAll() => _categories;

  @override
  Category? getById(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void add(String name) {
    if (name.trim().isEmpty) return;
    if (_categories.any((c) => c.name.toLowerCase() == name.toLowerCase())) {
      return;
    }
    
    _categories.add(Category(
      id: _categoryIdCounter.toString(),
      name: name,
      isDefault: false,
    ));
    _categoryIdCounter++;
  }

  @override
  void delete(String id) {
    _categories.removeWhere((c) => c.id == id && !c.isDefault);
  }

  @override
  void addBookToCategory(String bookId, String categoryId) {
    int index = _categories.indexWhere((c) => c.id == categoryId);
    if (index != -1) {
      if (!_categories[index].bookIds.contains(bookId)) {
        _categories[index] = _categories[index].copyWith(
          bookIds: [..._categories[index].bookIds, bookId],
        );
      }
    }
  }

  @override
  void removeBookFromCategory(String bookId, String categoryId) {
    int index = _categories.indexWhere((c) => c.id == categoryId);
    if (index != -1) {
      List<String> newBookIds = List.from(_categories[index].bookIds);
      newBookIds.remove(bookId);
      _categories[index] = _categories[index].copyWith(bookIds: newBookIds);
    }
  }

  @override
  List<Category> getCategoriesForBook(String bookId) {
    return _categories.where((cat) => cat.bookIds.contains(bookId)).toList();
  }
}