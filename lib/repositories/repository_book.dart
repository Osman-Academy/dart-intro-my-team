import 'package:book_finder/models/book/book.dart';
import 'package:book_finder/models/book/book_dto.dart';

abstract class RepositoryBook {
  Future<List<Book>> search(BookDto bookDto);
  Future<Book> view(BookDto bookDto);
}
