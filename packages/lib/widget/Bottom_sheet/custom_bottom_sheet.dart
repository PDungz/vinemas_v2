import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final double maxHeight;
  final double minHeight;
  final bool isDismissible;
  final VoidCallback? onClose;
  final Color backgroundColor;
  final Color barrierColor; // Thêm thuộc tính barrierColor

  const CustomBottomSheet({
    super.key,
    this.header,
    required this.body,
    this.maxHeight = 0.8,
    this.minHeight = 0.4,
    this.isDismissible = true,
    this.onClose,
    this.backgroundColor = AppColor.primaryColor,
    this.barrierColor = Colors.black54, // Giá trị mặc định cho overlay
  });

  static void show(
    BuildContext context, {
    Widget? header,
    required Widget body,
    double maxHeight = 0.8,
    double minHeight = 0.4,
    bool isDismissible = true,
    VoidCallback? onClose,
    Color backgroundColor = AppColor.primaryColor,
    Color barrierColor = Colors.black54, // Cho phép truyền barrierColor
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      barrierColor: barrierColor, // Sử dụng barrierColor được truyền vào
      builder: (context) => CustomBottomSheet(
        header: header,
        body: body,
        maxHeight: maxHeight,
        minHeight: minHeight,
        isDismissible: isDismissible,
        onClose: onClose,
        backgroundColor: backgroundColor,
        barrierColor: barrierColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: minHeight,
      minChildSize: minHeight,
      maxChildSize: maxHeight,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.7),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header hoặc drag handle
              if (header != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: header,
                )
              else
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              // Nút đóng nếu có
              if (onClose != null)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                      if (onClose != null) {
                        onClose!();
                      }
                    },
                  ),
                ),
              // Nội dung chính
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: body,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
