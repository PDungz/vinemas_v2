import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';

extension GenresExtension on List<Genres> {
  List<String> convertGenreIdsToNames(List<int> genreIds) {
    return genreIds
        .map((id) => firstWhere((genre) => genre.id == id).name)
        .toList();
  }
}
