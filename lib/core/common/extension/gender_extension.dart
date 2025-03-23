import 'package:vinemas_v1/core/common/enum/gender.dart';

extension GenderExtension on Gender {
  int toInt() {
    switch (this) {
      case Gender.female:
        return 1;
      case Gender.male:
        return 2;
      default:
        return 0;
    }
  }

  static Gender fromInt(int value) {
    switch (value) {
      case 1:
        return Gender.female;
      case 2:
        return Gender.male;
      default:
        return Gender.unknown;
    }
  }
}
