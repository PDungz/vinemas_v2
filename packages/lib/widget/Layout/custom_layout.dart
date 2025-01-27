import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout({
    super.key,
    required this.appBar,
    required this.body,
  });

  final Widget appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              body,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: appBar,
              ),
            ],
          ),
        ),
      );
}
