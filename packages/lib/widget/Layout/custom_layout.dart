import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout({
    super.key,
    required this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.bottomNavigationBar,
    this.backgroundWidget,
    this.isLoading = false,
    this.loadingOverlayColor = Colors.black54,
  });

  final Widget appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? backgroundWidget; // Nền tuỳ chỉnh
  final bool isLoading; // Trạng thái loading
  final Color loadingOverlayColor; // Màu nền mờ

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              if (backgroundWidget != null)
                Positioned.fill(child: backgroundWidget!), // Nền ở dưới cùng
              if (drawer != null)
                Positioned(
                  left: 0,
                  child: SizedBox(
                    width: 250, // Fixed width for drawer-like behavior
                    child: drawer,
                  ),
                ),
              body,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: appBar,
              ),
              if (floatingActionButton != null)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: floatingActionButton!,
                ),
              if (bottomNavigationBar != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: bottomNavigationBar!,
                ),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: loadingOverlayColor
                        .withOpacity(0.5), // Màu nền mờ tuỳ chỉnh
                    child: const Center(
                      child: CircularProgressIndicator(), // Hiển thị loading
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
