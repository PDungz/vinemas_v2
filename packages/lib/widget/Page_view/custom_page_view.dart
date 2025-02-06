import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({
    super.key,
    required this.pages,
    this.controller,
    this.onPageChanged,
    this.indicatorEffect = const ExpandingDotsEffect(),
    this.showIndicator = true,
    this.initialPage = 0,
    this.scrollDirection = Axis.horizontal,
    this.physics,
  });

  final List<Widget> pages;
  final PageController? controller;
  final ValueChanged<int>? onPageChanged;
  final IndicatorEffect indicatorEffect;
  final bool showIndicator;
  final int initialPage;
  final Axis scrollDirection;
  final ScrollPhysics? physics;

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? PageController(initialPage: widget.initialPage);
    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() => _currentPage = page);
        widget.onPageChanged?.call(page);
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.pages.length,
            scrollDirection: widget.scrollDirection,
            physics: widget.physics ?? const BouncingScrollPhysics(),
            itemBuilder: (context, index) => widget.pages[index],
          ),
        ),
        if (widget.showIndicator)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SmoothPageIndicator(
              controller: _controller,
              count: widget.pages.length,
              effect: widget.indicatorEffect,
            ),
          ),
      ],
    );
  }
}
