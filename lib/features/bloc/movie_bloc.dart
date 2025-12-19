import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/features/bloc/movie_event.dart';
import 'package:movie_search/common/di/service_locator.dart';
import 'package:movie_search/features/bloc/movie_state.dart';
import 'package:movie_search/repositories/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository = sl<MovieRepository>();

  MovieBloc() : super(MovieStateInitial()) {
    on<MovieLoadEvent>((event, emit) async {
      emit(MovieStateLoading());
      try {
        final movies = await repository.getAllMovies();
        print('Loaded ${movies.length} movies');
        emit(MovieStateLoaded(allMovies: movies, displayedMovies: movies));
      } catch (e) {
        print('Error loading movies: $e');
        emit(MovieStateError(message: e.toString()));
      }
    });

    on<MovieSearchEvent>((event, emit) {
  if (state is MovieStateLoaded) {
    final current = state as MovieStateLoaded;
    final query = event.query.toLowerCase().trim();

    if (query.isEmpty) {
      emit(MovieStateLoaded(
        allMovies: current.allMovies,
        displayedMovies: current.allMovies,
      ));
      return;
    }

    final filtered = current.allMovies.where((m) =>
        m.title.toLowerCase().contains(query) ||
        m.plot.toLowerCase().contains(query)).toList();

    emit(MovieStateLoaded(
      allMovies: current.allMovies,
      displayedMovies: filtered,
    ));
  }
});
  }
}