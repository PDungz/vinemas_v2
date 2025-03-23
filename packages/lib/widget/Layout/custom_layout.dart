import 'package:flutter/material.dart';

class CustomLayout extends StatefulWidget {
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
    this.overlayWidget,
  });

  final Widget appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? backgroundWidget;
  final bool isLoading;
  final Color loadingOverlayColor;
  final Widget? overlayWidget;

  @override
  State<CustomLayout> createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout> {
  late Offset position = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        position = Offset(
          MediaQuery.of(context).size.width - 68,
          MediaQuery.of(context).size.height - 160,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                if (widget.backgroundWidget != null)
                  Positioned.fill(child: widget.backgroundWidget!),
                if (widget.drawer != null)
                  Positioned(
                    left: 0,
                    child: SizedBox(
                      width: 250,
                      child: widget.drawer,
                    ),
                  ),
                widget.body,
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: widget.appBar,
                ),
                if (widget.floatingActionButton != null)
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: widget.floatingActionButton!,
                  ),
                if (widget.bottomNavigationBar != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: widget.bottomNavigationBar!,
                  ),
                if (widget.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: widget.loadingOverlayColor.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                if (widget.overlayWidget != null)
                  Positioned(
                    left: position.dx,
                    top: position.dy,
                    child: Draggable(
                      feedback: widget.overlayWidget!,
                      childWhenDragging: Container(),
                      onDragEnd: (details) {
                        setState(() {
                          final adjustmentHeight =
                              AppBar().preferredSize.height +
                                  MediaQuery.of(context).padding.top;
                          final maxX = constraints.maxWidth - 56;
                          final maxY = constraints.maxHeight - 56;
                          double dx = details.offset.dx.clamp(0, maxX);
                          double dy = (details.offset.dy - adjustmentHeight)
                              .clamp(0, maxY);
                          if (dy > MediaQuery.of(context).size.height - 100) {
                            dy = MediaQuery.of(context).size.height - 80;
                          }
                          position = Offset(dx, dy);
                        });
                      },
                      child: widget.overlayWidget!,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
