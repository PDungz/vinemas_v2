import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';

class CustomTabLabel extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final double indicatorHeight;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;

  const CustomTabLabel({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTap,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.indicatorHeight = 2.0,
    this.topPadding = 8.0,
    this.bottomPadding = 0.0,
    this.leftPadding = 0.0,
    this.rightPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final double indicatorWidth =
        MediaQuery.of(context).size.width / labels.length;

    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(labels.length, (index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => onTap(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: isSelected
                      ? CustomShadow(
                          spreadRadius: 1,
                          shadowOffset: Offset(0, 0),
                          shadowColor:
                              AppColor.buttonLinerOneColor.withOpacity(0.1),
                          child: Text(
                            labels[index],
                            style: (selectedTextStyle ??
                                TextStyle(
                                    color: selectedColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : Text(
                          labels[index],
                          style: (unselectedTextStyle ??
                              TextStyle(color: unselectedColor)),
                        ),
                ),
              );
            }),
          ),
          Stack(
            children: [
              Container(
                height: indicatorHeight,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      top: BorderSide(
                    color: AppColor.primaryIconColor,
                    width: 2,
                  )),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: indicatorWidth * selectedIndex,
                child: Container(
                  height: indicatorHeight,
                  width: indicatorWidth,
                  color: selectedColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
