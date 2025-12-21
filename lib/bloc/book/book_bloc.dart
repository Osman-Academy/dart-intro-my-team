import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_finder/bloc/book/book_event.dart';
import 'package:book_finder/bloc/book/book_state.dart';
import 'package:book_finder/models/book/book_dto.dart';
import 'package:book_finder/common/di/service_locator.dart';
import 'package:book_finder/usecases/book_usecase.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookUsecase usecase = sl<BookUsecase>();
  BookState? _previousSearchState;

  BookBloc() : super(BookStateInitial()) {
    on<BookSearchEvent>((event, emit) async {
      emit(BookStateLoading());
      try {
        var result = await usecase.bookRepo.search(BookDto(
          query: event.query,
          author: event.author,
          subject: event.subject,
        ));
        
        var booksWithFavorites = result.map((book) {
          return book.copyWith(isFavorite: usecase.isFavorite(book.id));
        }).toList();
        
        final newState = BookStateSuccess(books: booksWithFavorites);
        _previousSearchState = newState;
        emit(newState);
      } catch (e) {
        emit(BookStateError(message: "Failed to search books: $e"));
      }
    });

    on<BookViewEvent>((event, emit) async {
      emit(BookStateLoading());
      try {
        var result = await usecase.bookRepo.view(BookDto(bookId: event.bookId));
        var bookWithFavorite = result.copyWith(
          isFavorite: usecase.isFavorite(result.id),
        );
        emit(BookStateView(book: bookWithFavorite));
      } catch (e) {
        emit(BookStateError(message: "Failed to load book: $e"));
      }
    });

    on<BookToggleFavoriteEvent>((event, emit) {
      usecase.toggleFavorite(event.book);
      
      final currentState = state;
      
      if (currentState is BookStateSuccess) {
        var updatedBooks = currentState.books.map((book) {
          return book.id == event.book.id
              ? book.copyWith(isFavorite: usecase.isFavorite(book.id))
              : book;
        }).toList();
        final newState = BookStateSuccess(books: updatedBooks);
        _previousSearchState = newState;
        emit(newState);
      } else if (currentState is BookStateView) {
        var currentBook = currentState.book;
        emit(BookStateView(
          book: currentBook.copyWith(
            isFavorite: usecase.isFavorite(currentBook.id),
          ),
        ));
        if (_previousSearchState != null && _previousSearchState is BookStateSuccess) {
          var searchState = _previousSearchState as BookStateSuccess;
          var updatedBooks = searchState.books.map((book) {
            return book.id == event.book.id
                ? book.copyWith(isFavorite: usecase.isFavorite(book.id))
                : book;
          }).toList();
          _previousSearchState = BookStateSuccess(books: updatedBooks);
        }
      } else if (currentState is BookStateFavorites) {
        emit(BookStateFavorites(favorites: usecase.favoriteBooks));
      } else {
        emit(BookStateFavorites(favorites: usecase.favoriteBooks));
      }
    });

    on<BookLoadFavoritesEvent>((event, emit) {
      emit(BookStateFavorites(favorites: usecase.favoriteBooks));
    });
    
    on<BookRefreshCurrentEvent>((event, emit) {
      if (_previousSearchState != null && _previousSearchState is BookStateSuccess) {
        var searchState = _previousSearchState as BookStateSuccess;
        var updatedBooks = searchState.books.map((book) {
          return book.copyWith(isFavorite: usecase.isFavorite(book.id));
        }).toList();
        final newState = BookStateSuccess(books: updatedBooks);
        _previousSearchState = newState;
        emit(newState);
      }
    });
  }
}