import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_all_movies.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetAllMovies getAllMovies;

  MovieBloc(this.getAllMovies) : super(MovieStateInitial()) {
    on<MovieLoadEvent>((event, emit) async {
      emit(MovieStateLoading());
      try {
        final movies = await getAllMovies();
        final yearRange = _computeYearRange(movies);
        final ratingRange = _computeRatingRange(movies);

        final loaded = MovieStateLoaded(
          allMovies: movies,
          displayedMovies: movies,
          query: '',
          sortMode: SortMode.titleAsc,
          availableYearRange: yearRange,
          availableRatingRange: ratingRange,
          selectedYearRange: yearRange,
          selectedRatingRange: ratingRange,
        );

        emit(_recompute(loaded));
      } catch (e) {
        emit(MovieStateError(message: e.toString()));
      }
    });

    on<MovieSearchEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      emit(_recompute((state as MovieStateLoaded).copyWith(query: event.query)));
    });

    on<MovieSortChangedEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      emit(_recompute((state as MovieStateLoaded).copyWith(sortMode: event.sortMode)));
    });

    on<MovieYearRangeChangedEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      final s = state as MovieStateLoaded;
      emit(_recompute(s.copyWith(selectedYearRange: _clampRange(event.yearRange, s.availableYearRange))));
    });

    on<MovieRatingRangeChangedEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      final s = state as MovieStateLoaded;
      emit(_recompute(s.copyWith(selectedRatingRange: _clampRange(event.ratingRange, s.availableRatingRange))));
    });
  }

  MovieStateLoaded _recompute(MovieStateLoaded s) {
    final q = s.query.toLowerCase().trim();
    Iterable<Movie> result = s.allMovies;

    if (q.isNotEmpty) {
      result = result.where((m) => m.title.toLowerCase().contains(q));
    }

    final yStart = s.selectedYearRange.start;
    final yEnd = s.selectedYearRange.end;
    result = result.where((m) {
      final y = _parseYearStart(m.year);
      return y >= yStart && y <= yEnd;
    });

    final rStart = s.selectedRatingRange.start;
    final rEnd = s.selectedRatingRange.end;
    result = result.where((m) {
      final r = _parseRating(m.imdbRating);
      return r >= rStart && r <= rEnd;
    });

    final list = result.toList();
    switch (s.sortMode) {
      case SortMode.titleAsc:
        list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case SortMode.titleDesc:
        list.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
      case SortMode.yearAsc:
        list.sort((a, b) => _parseYearStart(a.year).compareTo(_parseYearStart(b.year)));
        break;
      case SortMode.yearDesc:
        list.sort((a, b) => _parseYearStart(b.year).compareTo(_parseYearStart(a.year)));
        break;
      case SortMode.ratingAsc:
        list.sort((a, b) => _parseRating(a.imdbRating).compareTo(_parseRating(b.imdbRating)));
        break;
      case SortMode.ratingDesc:
        list.sort((a, b) => _parseRating(b.imdbRating).compareTo(_parseRating(a.imdbRating)));
        break;
    }

    return s.copyWith(displayedMovies: list);
  }

  RangeValues _computeYearRange(List<Movie> movies) {
    final years = movies.map((m) => _parseYearStart(m.year)).where((y) => y > 0).toList();
    if (years.isEmpty) return const RangeValues(1900, 2100);
    years.sort();
    return RangeValues(years.first.toDouble(), years.last.toDouble());
  }

  RangeValues _computeRatingRange(List<Movie> movies) {
    final ratings = movies.map((m) => _parseRating(m.imdbRating)).where((r) => r > 0).toList();
    if (ratings.isEmpty) return const RangeValues(0, 10);
    ratings.sort();
    return RangeValues(ratings.first.clamp(0, 10), ratings.last.clamp(0, 10));
  }

  RangeValues _clampRange(RangeValues v, RangeValues bounds) {
    final start = v.start.clamp(bounds.start, bounds.end);
    final end = v.end.clamp(bounds.start, bounds.end);
    return start <= end ? RangeValues(start, end) : RangeValues(end, start);
  }

  int _parseYearStart(String year) {
    final digits = RegExp(r'\d{4}').firstMatch(year)?.group(0);
    return int.tryParse(digits ?? '') ?? 0;
  }

  double _parseRating(String rating) => double.tryParse(rating) ?? 0.0;
}
