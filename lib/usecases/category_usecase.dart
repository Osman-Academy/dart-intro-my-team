import 'package:book_finder/repositories/repository_category.dart';
import 'package:book_finder/models/category/category.dart';
import 'package:book_finder/models/category/category_dto.dart';

class CategoryUsecase {
  RepositoryCategory categoryRepo;

  CategoryUsecase({required this.categoryRepo});

  List<Category> getAllCategories() {
    return categoryRepo.getAll();
  }

  Category? getCategoryById(CategoryDto dto) {
    if (dto.categoryId == null) return null;
    return categoryRepo.getById(dto.categoryId!);
  }

  void createCategory(CategoryDto dto) {
    if (dto.name == null || dto.name!.isEmpty) return;
    categoryRepo.add(dto.name!);
  }

  void deleteCategory(CategoryDto dto) {
    if (dto.categoryId == null) return;
    categoryRepo.delete(dto.categoryId!);
  }

  void addBookToCategory(CategoryDto dto) {
    if (dto.bookId == null || dto.categoryId == null) return;
    categoryRepo.addBookToCategory(dto.bookId!, dto.categoryId!);
  }

  void removeBookFromCategory(CategoryDto dto) {
    if (dto.bookId == null || dto.categoryId == null) return;
    categoryRepo.removeBookFromCategory(dto.bookId!, dto.categoryId!);
  }

  List<Category> getCategoriesForBook(CategoryDto dto) {
    if (dto.bookId == null) return [];
    return categoryRepo.getCategoriesForBook(dto.bookId!);
  }

  int getBookCountInCategory(CategoryDto dto) {
    if (dto.categoryId == null) return 0;
    Category? category = categoryRepo.getById(dto.categoryId!);
    return category?.bookIds.length ?? 0;
  }

  bool canDeleteCategory(CategoryDto dto) {
    if (dto.categoryId == null) return false;
    Category? category = categoryRepo.getById(dto.categoryId!);
    return category != null && !category.isDefault;
  }

  Category? getCategoryByIdDirect(String id) {
    return categoryRepo.getById(id);
  }

  List<Category> getCategoriesForBookDirect(String bookId) {
    return categoryRepo.getCategoriesForBook(bookId);
  }
}