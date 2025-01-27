import 'package:flutter/material.dart';

class CustomLayoutVertical extends StatelessWidget {
  const CustomLayoutVertical({
    super.key,
    required this.topWidget,
    required this.bottomWidget,
    this.horizontalPadding = 16,
    this.verticalPadding = 8,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final Widget topWidget;
  final Widget bottomWidget;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          topWidget,
          SizedBox(
            height: 16,
          ),
          bottomWidget,
        ],
      ),
    );
  }
}
