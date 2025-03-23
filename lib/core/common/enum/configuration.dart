library;

//! Enum for image sizes used in different categories.

// Backdrop sizes
enum BackdropSize {
  w300,
  w780,
  w1280,
  original;

  String get value => name;
}

// Logo sizes
enum LogoSize {
  w45,
  w92,
  w154,
  w185,
  w300,
  w500,
  original;

  String get value => name;
}

// Poster sizes
enum PosterSize {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original;

  String get value => name;
}

// Profile sizes
enum ProfileSize {
  w45,
  w185,
  h632,
  original;

  String get value => name;
}

// Still sizes
enum StillSize {
  w92,
  w185,
  w300,
  original;

  String get value => name;
}
