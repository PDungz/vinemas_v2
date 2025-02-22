import 'package:flutter/material.dart';

class CustomLayoutHorizontal extends StatelessWidget {
  const CustomLayoutHorizontal({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    this.horizontalPadding = 16,
    this.verticalPadding = 8,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spaceWith = 0,
  });

  final Widget leftWidget;
  final Widget rightWidget;
  final double spaceWith;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          leftWidget,
          if (spaceWith > 0) SizedBox(width: spaceWith),
          rightWidget,
        ],
      ),
    );
  }
}
