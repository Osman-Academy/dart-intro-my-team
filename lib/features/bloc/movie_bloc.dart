import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/common/di/service_locator.dart';
import 'package:movie_search/features/bloc/movie_event.dart';
import 'package:movie_search/features/bloc/movie_state.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/repositories/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository = sl<MovieRepository>();

  MovieBloc() : super(MovieStateInitial()) {
    on<MovieLoadEvent>((event, emit) async {
      emit(MovieStateLoading());
      try {
        final movies = await repository.getAllMovies();

        final yearRange = _computeYearRange(movies);
        final ratingRange = _computeRatingRange(movies);

        final loaded = MovieStateLoaded(
          allMovies: movies,
          displayedMovies: movies,
          query: '',
          sortMode: SortMode.titleAsc,
          availableYearRange: yearRange,
          availableRatingRange: ratingRange,
          selectedYearRange: yearRange, // default: whole range
          selectedRatingRange: ratingRange, // default: whole range
        );

        emit(_recompute(loaded));
      } catch (e) {
        emit(MovieStateError(message: e.toString()));
      }
    });

    on<MovieSearchEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      final s = state as MovieStateLoaded;
      emit(_recompute(s.copyWith(query: event.query)));
    });

    on<MovieSortChangedEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      final s = state as MovieStateLoaded;
      emit(_recompute(s.copyWith(sortMode: event.sortMode)));
    });

    on<MovieYearRangeChangedEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      final s = state as MovieStateLoaded;

      // clamp to available range
      final clamped = _clampRange(event.yearRange, s.availableYearRange);
      emit(_recompute(s.copyWith(selectedYearRange: clamped)));
    });

    on<MovieRatingRangeChangedEvent>((event, emit) {
      if (state is! MovieStateLoaded) return;
      final s = state as MovieStateLoaded;

      // clamp to available range
      final clamped = _clampRange(event.ratingRange, s.availableRatingRange);
      emit(_recompute(s.copyWith(selectedRatingRange: clamped)));
    });
  }

  MovieStateLoaded _recompute(MovieStateLoaded s) {
    final q = s.query.toLowerCase().trim();

    Iterable<Movie> result = s.allMovies;

    // 1) Search
    if (q.isNotEmpty) {
      result = result.where((m) {
        final title = m.title.toLowerCase();
        final plot = m.plot.toLowerCase();
        return title.contains(q) || plot.contains(q);
      });
    }

    // 2) Year range filter
    final yStart = s.selectedYearRange.start;
    final yEnd = s.selectedYearRange.end;
    result = result.where((m) {
      final y = _parseYearStart(m.year).toDouble();
      if (y == 0) return false;
      return y >= yStart && y <= yEnd;
    });

    // 3) Rating range filter
    final rStart = s.selectedRatingRange.start;
    final rEnd = s.selectedRatingRange.end;
    result = result.where((m) {
      final r = _parseRating(m.imdbRating);
      if (r == 0) return false; // treat N/A as not passing filter
      return r >= rStart && r <= rEnd;
    });

    // 4) Sort
    final list = result.toList();

    switch (s.sortMode) {
      case SortMode.titleAsc:
        list.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SortMode.titleDesc:
        list.sort(
          (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()),
        );
        break;
      case SortMode.yearAsc:
        list.sort(
          (a, b) => _parseYearStart(a.year).compareTo(_parseYearStart(b.year)),
        );
        break;
      case SortMode.yearDesc:
        list.sort(
          (a, b) => _parseYearStart(b.year).compareTo(_parseYearStart(a.year)),
        );
        break;
      case SortMode.ratingAsc:
        list.sort(
          (a, b) =>
              _parseRating(a.imdbRating).compareTo(_parseRating(b.imdbRating)),
        );
        break;
      case SortMode.ratingDesc:
        list.sort(
          (a, b) =>
              _parseRating(b.imdbRating).compareTo(_parseRating(a.imdbRating)),
        );
        break;
    }

    return s.copyWith(displayedMovies: list);
  }

  RangeValues _computeYearRange(List<Movie> movies) {
    final years = movies
        .map((m) => _parseYearStart(m.year))
        .where((y) => y > 0)
        .toList();

    if (years.isEmpty) return const RangeValues(1900, 2100);

    years.sort();
    return RangeValues(years.first.toDouble(), years.last.toDouble());
  }

  RangeValues _computeRatingRange(List<Movie> movies) {
    final ratings = movies
        .map((m) => _parseRating(m.imdbRating))
        .where((r) => r > 0)
        .toList();

    if (ratings.isEmpty) return const RangeValues(0, 10);

    ratings.sort();
    final min = ratings.first;
    final max = ratings.last;

    // keep nice bounds inside 0..10
    return RangeValues(min.clamp(0, 10), max.clamp(0, 10));
  }

  RangeValues _clampRange(RangeValues v, RangeValues bounds) {
    final start = v.start.clamp(bounds.start, bounds.end);
    final end = v.end.clamp(bounds.start, bounds.end);
    if (start <= end) return RangeValues(start, end);
    return RangeValues(end, start);
  }

  int _parseYearStart(String year) {
    // year can be "1994" or "2005–2012" -> take first 4 digits
    final digits = RegExp(r'\d{4}').firstMatch(year)?.group(0);
    return int.tryParse(digits ?? '') ?? 0;
  }

  double _parseRating(String rating) {
    return double.tryParse(rating) ?? 0.0;
  }
}
