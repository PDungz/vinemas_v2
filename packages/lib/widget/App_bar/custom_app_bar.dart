import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:packages/Core/config/app_color.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color backgroundColor;
  final Brightness? brightness;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.elevation = 4.0,
    this.backgroundColor = AppColor.secondaryColor,
    this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: statusBarHeight + 8,
                  left: 16,
                  right: 16,
                  bottom: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    leading ?? const SizedBox.shrink(),
                    if (title != null)
                      Expanded(
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.titleLarge!,
                          child: Center(child: title!),
                        ),
                      ),
                    if (actions != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      ),
                  ],
                ),
              ),
              if (bottom != null) bottom!,
            ],
          ),
        ),
      ),
    );
  }
}
