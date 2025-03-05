abstract class Cinema {
  final String cinemaId;
  final String nameCinema;
  final String cinemaBandId;
  final String address;
  final DateTime openDate;
  final DateTime closeDate;
  final String description;
  final String chairConfigId;

  Cinema({
    required this.cinemaId,
    required this.nameCinema,
    required this.cinemaBandId,
    required this.address,
    required this.openDate,
    required this.closeDate,
    required this.description,
    required this.chairConfigId,
  });
}
