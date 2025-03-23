import 'dart:io';

import 'package:intl/intl.dart';

extension CurrencyExtension on int {
  /// Định dạng số thành chuỗi tiền tệ
  /// - Nếu không truyền `locale` và `currencyCode`, sẽ tự động lấy theo hệ thống
  String formatCurrency({String? locale, String? currencyCode}) {
    String systemLocale =
        locale ?? Platform.localeName; // Mặc định lấy locale hệ thống
    NumberFormat format;

    if (currencyCode != null) {
      format = NumberFormat.currency(
          locale: systemLocale, symbol: getCurrencySymbol(currencyCode));
    } else {
      format = NumberFormat.simpleCurrency(locale: systemLocale);
    }

    return format.format(this);
  }

  /// Lấy ký hiệu tiền tệ từ mã tiền tệ
  String getCurrencySymbol(String currencyCode) {
    Map<String, String> currencySymbols = {
      'VND': 'đ',
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
      'KRW': '₩',
      'CNY': '¥'
    };
    return currencySymbols[currencyCode] ?? currencyCode;
  }
}
