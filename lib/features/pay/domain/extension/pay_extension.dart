import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';

extension PayMethodExtension on PayMethodEnum {
  int toInt() {
    switch (this) {
      case PayMethodEnum.visa:
        return 0;
      case PayMethodEnum.masterCard:
        return 1;
      case PayMethodEnum.moMo:
        return 2;
      case PayMethodEnum.vnPay:
        return 3;
      case PayMethodEnum.cod:
        return 4;
    }
  }

  static PayMethodEnum fromInt(int value) {
    switch (value) {
      case 0:
        return PayMethodEnum.visa;
      case 1:
        return PayMethodEnum.masterCard;
      case 2:
        return PayMethodEnum.moMo;
      case 3:
        return PayMethodEnum.vnPay;
      default:
        return PayMethodEnum.cod;
    }
  }
}

extension PayStatusEnumExtension on PayStatusEnum {
  int toInt() {
    switch (this) {
      case PayStatusEnum.pending:
        return 0;
      case PayStatusEnum.completed:
        return 1;
      case PayStatusEnum.failed:
        return 2;
      case PayStatusEnum.refunded:
        return 3;
    }
  }

  static PayStatusEnum fromInt(int value) {
    switch (value) {
      case 0:
        return PayStatusEnum.pending;
      case 1:
        return PayStatusEnum.completed;
      case 2:
        return PayStatusEnum.failed;
      case 3:
        return PayStatusEnum.refunded;
      default:
        throw ArgumentError('Invalid PayStatusEnum value: $value');
    }
  }
}
