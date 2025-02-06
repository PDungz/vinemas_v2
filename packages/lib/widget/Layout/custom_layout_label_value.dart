import 'package:flutter/material.dart';

class CustomLayoutLabelValue extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final String value;
  final EdgeInsetsGeometry padding;
  final double labelWidth; // Thêm tham số để tuỳ chỉnh độ rộng của label

  const CustomLayoutLabelValue({
    super.key,
    required this.label,
    required this.value,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.labelWidth = 74,
    this.labelStyle,
    this.valueStyle, // Giá trị mặc định cho độ rộng label
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding, // Sử dụng padding tùy biến
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label với độ rộng cố định (có thể tùy chỉnh)
          SizedBox(
            width: labelWidth,
            child: Text(
              label,
              style: labelStyle ??
                  TextStyle(
                    color: Color(0xFF637393),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          const SizedBox(width: 16),
          // Value sẽ chiếm toàn bộ chiều rộng còn lại và có thể bọc chữ nếu cần
          Expanded(
            child: Text(
              value,
              style: valueStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
              softWrap: true, // Cho phép hiển thị nhiều dòng
              // overflow: TextOverflow
              //     .ellipsis, // Hiển thị dấu ba chấm nếu text quá dài
            ),
          ),
        ],
      ),
    );
  }
}
