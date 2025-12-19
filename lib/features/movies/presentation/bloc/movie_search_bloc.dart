import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_saved_movies.dart';
import '../../domain/usecases/search_movies.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

@injectable
class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;
  final GetPopularMovies getPopularMovies;
  
  String? _currentQuery;
  int _currentPage = 1;
  List<Movie> _allMovies = [];
  
  MovieSearchBloc({
    required this.searchMovies,
    required this.getPopularMovies,
  }) : super(const MovieSearchState.initial()) {
    on<SearchMoviesEvent>(_onSearchMovies);
    on<LoadPopularMoviesEvent>(_onLoadPopular);
    on<LoadMoreMoviesEvent>(_onLoadMore);
    on<ClearSearchEvent>(_onClearSearch);
  }
  
  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      return;
    }
    
    emit(const MovieSearchState.loading());
    
    _currentQuery = event.query;
    _currentPage = 1;
    _allMovies = [];
    
    final result = await searchMovies(event.query, _currentPage);
    
    result.fold(
      (failure) => emit(MovieSearchState.error(failure.message)),
      (movies) {
        _allMovies = movies;
        emit(MovieSearchState.loaded(
          movies: movies,
          currentPage: _currentPage,
          hasMorePages: movies.length >= 20, // обычно API возвращает 20 элементов
          searchQuery: event.query,
        ));
      },
    );
  }
  
  Future<void> _onLoadPopular(
    LoadPopularMoviesEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(const MovieSearchState.loading());
    
    _currentQuery = null;
    _currentPage = 1;
    _allMovies = [];
    
    final result = await getPopularMovies(_currentPage);
    
    result.fold(
      (failure) => emit(MovieSearchState.error(failure.message)),
      (movies) {
        _allMovies = movies;
        emit(MovieSearchState.loaded(
          movies: movies,
          currentPage: _currentPage,
          hasMorePages: movies.length >= 20,
        ));
      },
    );
  }
  
  Future<void> _onLoadMore(
    LoadMoreMoviesEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MovieSearchLoaded || !currentState.hasMorePages) {
      return;
    }
    
    _currentPage++;
    
    final result = _currentQuery != null
        ? await searchMovies(_currentQuery!, _currentPage)
        : await getPopularMovies(_currentPage);
    
    result.fold(
      (failure) {
        // если ошибка при загрузке следующей страницы, возвращаем предыдущее состояние
        _currentPage--;
      },
      (movies) {
        _allMovies.addAll(movies);
        emit(MovieSearchState.loaded(
          movies: List.from(_allMovies),
          currentPage: _currentPage,
          hasMorePages: movies.length >= 20,
          searchQuery: _currentQuery,
        ));
      },
    );
  }
  
  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<MovieSearchState> emit,
  ) {
    _currentQuery = null;
    _currentPage = 1;
    _allMovies = [];
    emit(const MovieSearchState.initial());
  }
}