enum SeatRowEnum {
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
  K,
  L,
  M,
  N,
  O,
  P,
  Q,
  R,
  S,
  T,
  U,
  V,
  W,
  X,
  Y,
  Z;
}

enum SeatTypeEnum {
  reserved, // Ghế đã đặt trước
  selected, // Ghế người dùng đã chọn
  regular, // Ghế thường
  vip, // Ghế VIP
  sweetbox, // Ghế Sweetbox (đôi)
}

enum ChairStatus {
  available(0), // Ghế trống
  booked(1), // Ghế đã đặt trước
  occupied(2), // Ghế đang sử dụng
  reserved(3), // Ghế được giữ chỗ
  vip(4), // Ghế VIP
  broken(5), // Ghế bị hỏng
  disabled(6); // Ghế cho người khuyết tật

  final int value;
  const ChairStatus(this.value);
}
