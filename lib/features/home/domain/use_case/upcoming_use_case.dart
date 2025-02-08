// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/repository/upcoming_repository.dart';

class UpcomingUseCase {
  final UpcomingRepository _upcomingRepository;

  UpcomingUseCase(
    this._upcomingRepository,
  );

  Future<List<Movie>?> getUpcoming(
      {String language = 'en', int page = 1}) async {
    return await _upcomingRepository.getUpcomming(
        language: language, page: page);
  }
}
