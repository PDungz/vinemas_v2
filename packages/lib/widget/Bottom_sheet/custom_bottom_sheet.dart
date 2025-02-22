import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget? header;
  final Widget body;
  final double maxHeight;
  final double minHeight;
  final bool isDismissible;
  final VoidCallback? onClose;
  final Color backgroundColor;
  final Color barrierColor;

  const CustomBottomSheet({
    super.key,
    this.header,
    required this.body,
    this.maxHeight = 0.8,
    this.minHeight = 0.4,
    this.isDismissible = true,
    this.onClose,
    this.backgroundColor = AppColor.primaryColor,
    this.barrierColor = Colors.black54,
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
    Color barrierColor = Colors.black54,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      barrierColor: barrierColor,
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
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: widget.minHeight,
      minChildSize: widget.minHeight,
      maxChildSize: widget.maxHeight,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              if (widget.header != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: widget.header,
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

              // Nút đóng
              if (widget.onClose != null)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onClose?.call();
                    },
                  ),
                ),

              // Nội dung chính (scrollable)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: widget.body,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
