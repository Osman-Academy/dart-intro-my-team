import 'package:flutter/material.dart';

enum SortMode {
  titleAsc, // A -> Z
  titleDesc, // Z -> A
  yearAsc, // old -> new
  yearDesc, // new -> old
  ratingAsc, // low -> high
  ratingDesc, // high -> low
}

abstract class MovieEvent {}

class MovieLoadEvent implements MovieEvent {}

class MovieSearchEvent implements MovieEvent {
  final String query;
  MovieSearchEvent({required this.query});
}

class MovieSortChangedEvent implements MovieEvent {
  final SortMode sortMode;
  MovieSortChangedEvent({required this.sortMode});
}

class MovieYearRangeChangedEvent implements MovieEvent {
  final RangeValues yearRange; // doubles, but represent years
  MovieYearRangeChangedEvent({required this.yearRange});
}

class MovieRatingRangeChangedEvent implements MovieEvent {
  final RangeValues ratingRange; // e.g. 0..10
  MovieRatingRangeChangedEvent({required this.ratingRange});
}
