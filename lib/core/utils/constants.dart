// Константы приложения
class AppConstants {
  // API конфигурация
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // TMDB API Key
  static const String apiKey = '54e866725bf8e3a18b08339613d4ca9a';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String imageBaseUrlOriginal =
      'https://image.tmdb.org/t/p/original';

  // Endpoints
  static const String searchMoviesEndpoint = '/search/movie';
  static const String movieDetailsEndpoint = '/movie';
  static const String popularMoviesEndpoint = '/movie/popular';

  // Local storage keys
  static const String savedMoviesKey = 'saved_movies';

  // UI константы
  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 12.0;
}
