import 'package:book_finder/repositories/repository_book.dart';
import 'package:book_finder/repositories/repository_category.dart';
import 'package:book_finder/models/book/book.dart';

class BookUsecase {
  RepositoryBook bookRepo;
  RepositoryCategory categoryRepo;
  List<Book> favoriteBooks = [];

  BookUsecase({required this.bookRepo, required this.categoryRepo});

  void toggleFavorite(Book book) {
    if (favoriteBooks.any((b) => b.id == book.id)) {
      favoriteBooks.removeWhere((b) => b.id == book.id);
      for (var category in categoryRepo.getAll()) {
        categoryRepo.removeBookFromCategory(book.id, category.id);
      }
    } else {
      favoriteBooks.add(book.copyWith(isFavorite: true));
    }
  }

  bool isFavorite(String bookId) {
    return favoriteBooks.any((b) => b.id == bookId);
  }

  List<Book> getBooksInCategory(String categoryId) {
    var category = categoryRepo.getById(categoryId);
    if (category == null) return [];
    
    return favoriteBooks
        .where((book) => category.bookIds.contains(book.id))
        .toList();
  }
}