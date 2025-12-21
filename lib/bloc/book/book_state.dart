import 'package:book_finder/models/book/book.dart';

abstract class BookState {}

class BookStateInitial implements BookState {}

class BookStateLoading implements BookState {}

class BookStateSuccess implements BookState {
  final List<Book> books;
  BookStateSuccess({required this.books});
}

class BookStateView implements BookState {
  final Book book;
  BookStateView({required this.book});
}

class BookStateFavorites implements BookState {
  final List<Book> favorites;
  BookStateFavorites({required this.favorites});
}

class BookStateError implements BookState {
  final String message;
  BookStateError({required this.message});
}