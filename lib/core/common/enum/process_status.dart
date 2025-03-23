enum ProcessStatus {
  idle, // Không xử lý, trạng thái rảnh
  loading, // Đang xử lý
  success, // Xử lý thành công
  failure, // Xử lý thất bại
  noData, // Không có dữ liệu
  validating, // Đang kiểm tra dữ liệu
  submitting, // Đang gửi dữ liệu
  timeout, // 
  cancelled, // Hủy bỏ xử lý
  warning, // Có cảnh báo trong quá trình xử lý
  unknown // Trạng thái không xác định
}
