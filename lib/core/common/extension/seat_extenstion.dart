import 'dart:ui';

import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/config/app_color.dart';

extension SeatTypeExtension on SeatTypeEnum {
  Color get color {
    switch (this) {
      case SeatTypeEnum.reserved:
        return AppColor.secondaryTextColor.withOpacity(0.1); // Ghế đã đặt trước
      case SeatTypeEnum.selected:
        return AppColor.buttonLinerOneColor; // Ghế người dùng chọn
      case SeatTypeEnum.regular:
        return AppColor.accentColor.withOpacity(0.6); // Ghế thường
      case SeatTypeEnum.vip:
        return AppColor.accentColor; // Ghế VIP
      case SeatTypeEnum.sweetbox:
        return AppColor.secondaryTextColor
            .withOpacity(0.6); // Ghế Sweetbox (đôi)
    }
  }
}

extension ChairStatusExtension on ChairStatus {
  int get value {
    switch (this) {
      case ChairStatus.available:
        return 0;
      case ChairStatus.booked:
        return 1;
      case ChairStatus.occupied:
        return 2;
      case ChairStatus.reserved:
        return 3;
      case ChairStatus.vip:
        return 4;
      case ChairStatus.broken:
        return 5;
      case ChairStatus.disabled:
        return 6;
    }
  }

  static ChairStatus fromValue(int value) {
    return ChairStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => ChairStatus.available, // Mặc định là ghế trống
    );
  }
}
