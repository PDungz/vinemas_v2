import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarousel<T> extends StatefulWidget {
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
    required this.onTap,
    required this.listUrlImage,
    this.isLoading = false, // ✅ Truyền trạng thái loading từ bên ngoài
  });

  final List<T> listItem;
  final List<String> listUrlImage;
  final double heightImage;
  final double viewportFraction;
  final double aspectRatio;
  final double enlargeFactor;
  final bool isSmoothIndicator;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final ValueChanged<int>? onPageChanged;
  final int visibleIndicatorCount;
  final Function({required T parameter}) onTap;
  final bool isLoading; // ✅ Trạng thái loading

  @override
  State<CustomCarousel> createState() => _CustomCarouselState<T>();
}

class _CustomCarouselState<T> extends State<CustomCarousel<T>> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isLoading)
          // ✅ Hiển thị 3 ảnh giả lập khi đang tải
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomShimmer(
                    baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                    highlightColor:
                        AppColor.buttonLinerOneColor.withOpacity(0.6),
                    height: widget.heightImage,
                    width: double.infinity,
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
          )
        else
          // ✅ Hiển thị ảnh thật khi tải xong
          CarouselSlider.builder(
            itemCount: widget.listItem.length,
            itemBuilder: (context, index, realIndex) {
              final itemIndex = index % widget.listItem.length;
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GestureDetector(
                  onTap: () {
                    widget.onTap(parameter: widget.listItem[itemIndex]);
                  },
                  child: Image.network(
                    widget.listUrlImage[itemIndex],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CustomShimmer(
                        baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                        highlightColor:
                            AppColor.buttonLinerOneColor.withOpacity(0.6),
                        height: widget.heightImage,
                        width: double.infinity,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
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
        if (!widget.isLoading && widget.isSmoothIndicator) ...[
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
        ],
      ],
    );
  }
}
