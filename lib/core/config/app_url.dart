import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrl {
  // API KEY GEMINI
  static String get apiKeyGemini => dotenv.env['API_KEY_GEMINI'] ?? '';

  // API PAY
  static String get urlPay => dotenv.env['URL_PAY'] ?? '';
  static String get publishableKey => dotenv.env['PUBLISHABLE_KEY'] ?? '';
  static String get secretKey => dotenv.env['SECRET_KEY'] ?? '';

  static String get apiHost => dotenv.env['API_HOST'] ?? '';
  static String get versionApi => dotenv.env['API_VERSION'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  // API CONFIGURATION
  static String get apiConfigurationDetails =>
      dotenv.env['API_CONFIGURATION_DETAILS'] ?? '';
  static String get apiConfigurationCountries =>
      dotenv.env['API_CONFIGURATION_COUNTRIES'] ?? '';
  static String get apiConfigurationJobs =>
      dotenv.env['API_CONFIGURATION_JOBS'] ?? '';
  static String get apiConfigurationLanguages =>
      dotenv.env['API_CONFIGURATION_LANGUAGES'] ?? '';
  static String get apiConfigurationPrimaryTranslations =>
      dotenv.env['API_CONFIGURATION_PRIMARY_TRANSLATIONS'] ?? '';
  static String get apiConfigurationTimezones =>
      dotenv.env['API_CONFIGURATION_TIMEZONES'] ?? '';

  // API GENRES
  static String get apiGenresMovieList =>
      dotenv.env['API_GENRES_MOVIE_LIST'] ?? '';
  static String get apiGenresTvList => dotenv.env['API_GENRES_TV_LIST'] ?? '';

  // API MOVIE LISTS
  static String get apiMovieListNowPlaying =>
      dotenv.env['API_MOVIE_LIST_NOW_PLAYING'] ?? '';
  static String get apiMovieListPopular =>
      dotenv.env['API_MOVIE_LIST_POPULAR'] ?? '';
  static String get apiMovieListTopRated =>
      dotenv.env['API_MOVIE_LIST_TOP_RATED'] ?? '';
  static String get apiMovieListUpcoming =>
      dotenv.env['API_MOVIE_LIST_UPCOMING'] ?? '';

  // API MOVIE
  static String movieDetails(int movieId) =>
      '${dotenv.env['API_MOVIE_DETAILS']}$movieId';
  static String movieAlternativeTitles(int movieId) =>
      '${dotenv.env['API_MOVIE_ALTERNATIVE_TITLES']}'
          .replaceAll('{movie_id}', movieId.toString());
  static String movieImages(String movieId) =>
      '${dotenv.env['API_MOVIE_IMAGES']}'
          .replaceAll('{movie_id}', movieId.toString());
  static String movieRecommendations(int movieId) =>
      '${dotenv.env['API_MOVIE_RECOMMENDATIONS']}'
          .replaceAll('{movie_id}', movieId.toString());
  static String movieReleaseDates(int movieId) =>
      '${dotenv.env['API_MOVIE_RELEASE_DATES']}'
          .replaceAll('{movie_id}', movieId.toString());
  static String movieSimilar(int movieId) =>
      '${dotenv.env['API_MOVIE_SIMILAR']}'
          .replaceAll('{movie_id}', movieId.toString());
  static String movieTranslations(int movieId) =>
      '${dotenv.env['API_MOVIE_TRANSLATIONS']}'
          .replaceAll('{movie_id}', movieId.toString());
  static String movieVideos(int movieId) => '${dotenv.env['API_MOVIE_VIDEOS']}'
      .replaceAll('{movie_id}', movieId.toString());
  static String movieWatchProviders(int movieId) =>
      '${dotenv.env['API_MOVIE_WATCH_PROVIDERS']}'
          .replaceAll('{movie_id}', movieId.toString());

  // API CAST
  static String movieCast(int movieId) => '${dotenv.env['API_MOVIE_CAST']}'
      .replaceAll('{movie_id}', movieId.toString());

  // API SEARCH
  static String get apiSearchCollection =>
      dotenv.env['API_SEARCH_COLLECTION'] ?? '';
  static String get apiSearchCompany => dotenv.env['API_SEARCH_COMPANY'] ?? '';
  static String get apiSearchKeyword => dotenv.env['API_SEARCH_KEYWORD'] ?? '';
  static String get apiSearchMovie => dotenv.env['API_SEARCH_MOVIE'] ?? '';
  static String get apiSearchMulti => dotenv.env['API_SEARCH_MULTI'] ?? '';

  static Future<void> initDotEnv() async {
    await dotenv.load(fileName: '.env');
  }
}
