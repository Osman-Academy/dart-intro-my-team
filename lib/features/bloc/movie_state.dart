import 'package:flutter/material.dart';
import 'package:movie_search/features/bloc/movie_event.dart';
import 'package:movie_search/models/movie.dart';

abstract class MovieState {}

class MovieStateInitial implements MovieState {}

class MovieStateLoading implements MovieState {}

class MovieStateLoaded implements MovieState {
  final List<Movie> allMovies;
  final List<Movie> displayedMovies;

  final String query;
  final SortMode sortMode;

  /// Available ranges (computed from dataset)
  final RangeValues availableYearRange; // e.g. 1950..2015
  final RangeValues availableRatingRange; // e.g. 1.0..9.5

  /// Selected ranges (user)
  final RangeValues selectedYearRange;
  final RangeValues selectedRatingRange;

  MovieStateLoaded({
    required this.allMovies,
    required this.displayedMovies,
    required this.query,
    required this.sortMode,
    required this.availableYearRange,
    required this.availableRatingRange,
    required this.selectedYearRange,
    required this.selectedRatingRange,
  });

  MovieStateLoaded copyWith({
    List<Movie>? allMovies,
    List<Movie>? displayedMovies,
    String? query,
    SortMode? sortMode,
    RangeValues? availableYearRange,
    RangeValues? availableRatingRange,
    RangeValues? selectedYearRange,
    RangeValues? selectedRatingRange,
  }) {
    return MovieStateLoaded(
      allMovies: allMovies ?? this.allMovies,
      displayedMovies: displayedMovies ?? this.displayedMovies,
      query: query ?? this.query,
      sortMode: sortMode ?? this.sortMode,
      availableYearRange: availableYearRange ?? this.availableYearRange,
      availableRatingRange: availableRatingRange ?? this.availableRatingRange,
      selectedYearRange: selectedYearRange ?? this.selectedYearRange,
      selectedRatingRange: selectedRatingRange ?? this.selectedRatingRange,
    );
  }
}

class MovieStateError implements MovieState {
  final String message;
  MovieStateError({required this.message});
}
