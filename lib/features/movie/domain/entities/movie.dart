class Movie {
  final String title;
  final String year;
  final String plot;
  final String poster;
  final String imdbRating;
  final String imdbID;
  final String actors;
  final String awards;
  final String language;
  final String country;
  final String metascore;
  final String rated;
  final String director;
  final String writer;
  final String genre;
  final String runtime;
  final String released;
  final List<String> images;

  const Movie({
    required this.title,
    required this.year,
    required this.plot,
    required this.poster,
    required this.imdbRating,
    required this.imdbID,
    required this.actors,
    required this.awards,
    required this.language,
    required this.country,
    required this.metascore,
    required this.rated,
    required this.director,
    required this.writer,
    required this.genre,
    required this.runtime,
    required this.released,
    required this.images,
  });

  

  String get safePoster {
    if (poster.isEmpty || poster == 'N/A') {
      return 'https://via.placeholder.com/300x450';
    }
    return poster.startsWith('http://')
        ? poster.replaceFirst('http://', 'https://')
        : poster;
  }
}
