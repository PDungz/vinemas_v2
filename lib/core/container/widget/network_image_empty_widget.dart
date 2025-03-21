import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class NetworkImageEmptyWidget extends StatelessWidget {
  const NetworkImageEmptyWidget({
    super.key,
    required this.posterImgPath,
    this.widgetChild,
    this.minHeight = 230,
    this.maxWidth = 160,
  });

  final String posterImgPath;
  final Widget? widgetChild;
  final double minHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return posterImgPath.isNotEmpty
        ? Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                constraints:
                    BoxConstraints(minHeight: minHeight, maxWidth: maxWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    posterImgPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Hiển thị Container thay thế khi lỗi xảy ra
                      return Container(
                        padding: const EdgeInsets.all(4),
                        constraints: BoxConstraints(minHeight: minHeight),
                        decoration: BoxDecoration(
                          color: AppColor.secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            $AssetsSvgGen().popcorn,
                            fit: BoxFit.contain,
                            width: 36.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: widgetChild ?? SizedBox(),
              )
            ],
          )
        : Container(
            padding: const EdgeInsets.all(4),
            constraints: BoxConstraints(minHeight: minHeight),
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              $AssetsSvgGen().appIcon,
              fit: BoxFit.contain,
            ),
          );
  }
}
