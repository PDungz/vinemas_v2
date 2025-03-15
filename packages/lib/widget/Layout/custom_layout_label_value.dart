import 'package:flutter/material.dart';

class CustomLayoutLabelValue extends StatelessWidget {
  final Widget widgetLeft;
  final Widget widgetRight;
  final EdgeInsetsGeometry padding;
  final double labelWidth;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomLayoutLabelValue({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.labelWidth = 74,
    required this.widgetLeft,
    required this.widgetRight,
    this.mainAxisAlignment = MainAxisAlignment.start, // Mặc định căn trái
    this.crossAxisAlignment = CrossAxisAlignment.center, // Mặc định căn giữa
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SizedBox(
            width: labelWidth,
            child: widgetLeft,
          ),
          const SizedBox(width: 16),
          const Text(":  "),
          Expanded(
            child: widgetRight,
          ),
        ],
      ),
    );
  }
}
