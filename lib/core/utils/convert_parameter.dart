class ConvertParameter {
  /// Chuyển đổi số điện thoại từ định dạng Việt Nam 0XXXXXXXXX thành +84XXXXXXXXX
  static String toInternationalFormat(String phoneNumber) {
    if (phoneNumber.startsWith('0') && phoneNumber.length == 10) {
      return '+84${phoneNumber.substring(1)}';
    }
    return phoneNumber; // Không thay đổi nếu không đúng định dạng
  }

  /// Chuyển đổi số điện thoại từ định dạng quốc tế +84XXXXXXXXX thành 0XXXXXXXXX
  static String toLocalFormat(String phoneNumber) {
    if (phoneNumber.startsWith('+84') && phoneNumber.length == 12) {
      return '0${phoneNumber.substring(3)}';
    }
    return phoneNumber; // Không thay đổi nếu không đúng định dạng
  }
}
