import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';

extension PayMethodExtension on PayMethodEnum {
  int toInt() {
    switch (this) {
      case PayMethodEnum.card:
        return 0;
      case PayMethodEnum.eWallet:
        return 1;
      case PayMethodEnum.cod:
        return 2;
    }
  }

  static PayMethodEnum fromInt(int value) {
    switch (value) {
      case 0:
        return PayMethodEnum.card;
      case 1:
        return PayMethodEnum.eWallet;
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
