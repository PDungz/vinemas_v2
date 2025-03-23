class ImageConfig {
  String baseUrl;
  String secureBaseUrl;
  List<String> backdropSizes;
  List<String> logoSizes;
  List<String> posterSizes;
  List<String> profileSizes;
  List<String> stillSizes;

  ImageConfig({
    required this.baseUrl,
    required this.secureBaseUrl,
    required this.backdropSizes,
    required this.logoSizes,
    required this.posterSizes,
    required this.profileSizes,
    required this.stillSizes,
  });

  String getPosterSizes(String parameter) {
    final String value = posterSizes.firstWhere(
      (element) => element == parameter,
      orElse: () => 'original',
    );
    return value;
  }
}
