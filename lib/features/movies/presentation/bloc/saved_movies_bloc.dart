import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_saved_movies.dart';
import '../../domain/usecases/save_movie.dart';

part 'saved_movies_bloc.freezed.dart';
part 'saved_movies_event.dart';
part 'saved_movies_state.dart';

@injectable
class SavedMoviesBloc extends Bloc<SavedMoviesEvent, SavedMoviesState> {
  final GetSavedMovies getSavedMovies;
  final SaveMovie saveMovie;
  final RemoveSavedMovie removeSavedMovie;
  
  SavedMoviesBloc({
    required this.getSavedMovies,
    required this.saveMovie,
    required this.removeSavedMovie,
  }) : super(const SavedMoviesState.initial()) {
    on<LoadSavedMoviesEvent>(_onLoadSavedMovies);
    on<AddMovieEvent>(_onAddMovie);
    on<RemoveMovieEvent>(_onRemoveMovie);
  }
  
  Future<void> _onLoadSavedMovies(
    LoadSavedMoviesEvent event,
    Emitter<SavedMoviesState> emit,
  ) async {
    emit(const SavedMoviesState.loading());
    
    final result = await getSavedMovies();
    
    result.fold(
      (failure) => emit(SavedMoviesState.error(failure.message)),
      (movies) => emit(SavedMoviesState.loaded(movies)),
    );
  }
  
  Future<void> _onAddMovie(
    AddMovieEvent event,
    Emitter<SavedMoviesState> emit,
  ) async {
    final result = await saveMovie(event.movie);
    
    result.fold(
      (failure) {
        // Логируем ошибку для отладки
        print('Failed to save movie: ${failure.message}');
        
        add(const SavedMoviesEvent.loadSaved());
      },
      (_) {
        // Успешно сохранили - перезагружаем список
        add(const SavedMoviesEvent.loadSaved());
      },
    );
  }
  
  Future<void> _onRemoveMovie(
    RemoveMovieEvent event,
    Emitter<SavedMoviesState> emit,
  ) async {
    final result = await removeSavedMovie(event.movieId);
    
    result.fold(
      (failure) {
        // Логируем ошибку
        print('Failed to remove movie: ${failure.message}');
        
        add(const SavedMoviesEvent.loadSaved());
      },
      (_) {
        // Успешно удалили - обновляем список
        add(const SavedMoviesEvent.loadSaved());
      },
    );
  }
}