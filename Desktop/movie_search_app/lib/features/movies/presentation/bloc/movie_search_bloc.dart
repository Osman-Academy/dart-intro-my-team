import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/search_movies.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

@injectable
class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(const MovieSearchState.initial()) {
    on<SearchMoviesEvent>(_onSearchMovies);
    on<LoadPopularMoviesEvent>(_onLoadPopularMovies);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const MovieSearchState.initial());
      return;
    }

    emit(const MovieSearchState.loading());

    final result = await searchMovies(
      SearchMoviesParams(query: event.query),
    );

    result.fold(
      (failure) => emit(MovieSearchState.error(failure.message)),
      (movies) => emit(MovieSearchState.loaded(movies)),
    );
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMoviesEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(const MovieSearchState.loading());

    final result = await searchMovies(
      SearchMoviesParams(query: ''),
    );

    result.fold(
      (failure) => emit(MovieSearchState.error(failure.message)),
      (movies) => emit(MovieSearchState.loaded(movies)),
    );
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(const MovieSearchState.initial());
  }
}