
// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class CinemaBand {
  final String? cinemaBandId;
  final String? imageUrl;
  final String? nameCinema;
  final String? openDate;
  final String? closeDate;

  CinemaBand({
    this.cinemaBandId,
    this.imageUrl,
    this.nameCinema,
    this.openDate,
    this.closeDate,
  });
}
