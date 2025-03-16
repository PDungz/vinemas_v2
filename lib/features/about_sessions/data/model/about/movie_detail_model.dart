import 'package:vinemas_v1/core/global/api/genres/data/model/genres_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/about/production_company_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/about/production_country_model.dart';
import 'package:vinemas_v1/features/about_sessions/data/model/about/spoken_language_model.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel({
    required super.adult,
    required super.budget,
    required super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originCountry,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.productionCompanies,
    required super.productionCountries,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.spokenLanguages,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
    required super.backdropPath,
    required super.posterPath,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List?)
              ?.map((e) => GenresModel.fromJson(e))
              .toList() ??
          [],
      homepage: json['homepage'] ?? '',
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'] ?? '',
      originCountry: (json['origin_country'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      posterPath: json['poster_path'] ?? '',
      productionCompanies: (json['production_companies'] as List?)
              ?.map((e) => ProductionCompanyModel.fromJson(e))
              .toList() ??
          [],
      productionCountries: (json['production_countries'] as List?)
              ?.map((e) => ProductionCountryModel.fromJson(e))
              .toList() ??
          [],
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages: (json['spoken_languages'] as List?)
              ?.map((e) => SpokenLanguageModel.fromJson(e))
              .toList() ??
          [],
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
    );
  }
}
