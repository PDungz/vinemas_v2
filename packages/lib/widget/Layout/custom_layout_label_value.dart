import 'package:flutter/material.dart';

class CustomLayoutLabelValue extends StatelessWidget {
  final Widget widgetLeft;
  final Widget widgetRight;
  final EdgeInsetsGeometry padding;
  final double labelWidth;

  const CustomLayoutLabelValue({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.labelWidth = 74,
    required this.widgetLeft,
    required this.widgetRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: widgetLeft,
          ),
          const SizedBox(width: 16),
          Text(":  "),
          Expanded(
            child: widgetRight,
          ),
        ],
      ),
    );
  }
}
