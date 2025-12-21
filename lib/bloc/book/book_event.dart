import 'package:book_finder/models/book/book.dart';

abstract class BookEvent {}

class BookSearchEvent implements BookEvent {
  String? query;
  String? author;
  String? subject;
  
  BookSearchEvent({this.query, this.author, this.subject});
}

class BookViewEvent implements BookEvent {
  String bookId;
  BookViewEvent({required this.bookId});
}

class BookToggleFavoriteEvent implements BookEvent {
  Book book;
  BookToggleFavoriteEvent({required this.book});
}

class BookLoadFavoritesEvent implements BookEvent {}

class BookRefreshCurrentEvent implements BookEvent {}