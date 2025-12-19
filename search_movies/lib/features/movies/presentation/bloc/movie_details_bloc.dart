import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../domain/usecases/save_movie.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

@injectable
class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetails getMovieDetails;
  final SaveMovie saveMovie;
  final RemoveSavedMovie removeSavedMovie;
  
  Movie? _currentMovie;
  
  MovieDetailsBloc({
    required this.getMovieDetails,
    required this.saveMovie,
    required this.removeSavedMovie,
  }) : super(const MovieDetailsState.initial()) {
    on<LoadMovieDetailsEvent>(_onLoadDetails);
    on<ToggleSaveEvent>(_onToggleSave);
  }
  
  Future<void> _onLoadDetails(
    LoadMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(const MovieDetailsState.loading());
    
    final result = await getMovieDetails(event.movieId);
    
    result.fold(
      (failure) => emit(MovieDetailsState.error(failure.message)),
      (movie) {
        _currentMovie = movie;
        emit(MovieDetailsState.loaded(movie));
      },
    );
  }
  
  Future<void> _onToggleSave(
    ToggleSaveEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    if (_currentMovie == null) return;
    
    if (_currentMovie!.isSaved) {
      // Удаляем из сохраненных
      await removeSavedMovie(_currentMovie!.id);
      _currentMovie = _currentMovie!.copyWith(isSaved: false);
    } else {
      // Сохраняем
      await saveMovie(_currentMovie!);
      _currentMovie = _currentMovie!.copyWith(isSaved: true);
    }
    
    emit(MovieDetailsState.loaded(_currentMovie!));
  }
}