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
    this.spaceHeight = 0,
  });

  final Widget topWidget;
  final Widget bottomWidget;
  final double spaceHeight;
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
          if (spaceHeight > 0) SizedBox(height: spaceHeight),
          bottomWidget,
        ],
      ),
    );
  }
}
