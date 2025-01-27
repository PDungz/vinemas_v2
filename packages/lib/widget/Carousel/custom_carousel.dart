import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    super.key,
    required this.listItem,
    this.heightImage = 220,
    this.viewportFraction = 0.5,
    this.aspectRatio = 16 / 9,
    this.enlargeFactor = 0.3,
    this.isSmoothIndicator = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.onPageChanged,
    this.visibleIndicatorCount = 5,
  });

  final List<String> listItem;
  final double heightImage;
  final double viewportFraction;
  final double aspectRatio;
  final double enlargeFactor;
  final bool isSmoothIndicator;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final ValueChanged<int>? onPageChanged;
  final int visibleIndicatorCount;

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.listItem.length,
          itemBuilder: (context, index, realIndex) {
            final itemIndex = index % widget.listItem.length;
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {},
                child: Image.network(
                  widget.listItem[itemIndex],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.heightImage,
            viewportFraction: widget.viewportFraction,
            aspectRatio: widget.aspectRatio,
            enlargeCenterPage: true,
            enlargeFactor: widget.enlargeFactor,
            enableInfiniteScroll: true,
            initialPage: widget.listItem.length,
            autoPlay: true,
            autoPlayInterval: widget.autoPlayInterval,
            autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              final actualIndex = index % widget.listItem.length;
              setState(() => _currentIndex = actualIndex);
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(actualIndex);
              }
            },
          ),
        ),
        if (widget.isSmoothIndicator) ...[
          const SizedBox(height: 12),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: widget.listItem.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColor.buttonLinerTwoColor,
              expansionFactor: 2.5,
              spacing: 6,
              dotHeight: 8,
              dotWidth: 8,
              dotColor: AppColor.secondaryColor,
            ),
          ),
        ]
      ],
    );
  }
}
