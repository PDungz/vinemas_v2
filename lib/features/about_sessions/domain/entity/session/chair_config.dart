abstract class ChairConfig {
  final String chairConfigId;
  final String layout;
  final num rowCount;
  final num seatsPerRow;
  final Map<String, List<String>> chairTypes;


  ChairConfig({
    required this.chairConfigId,
    required this.layout,
    required this.rowCount,
    required this.seatsPerRow,
    required this.chairTypes,
  });
}
