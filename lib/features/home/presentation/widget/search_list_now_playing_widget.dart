import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Text/custom_text.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

class SearchListNowPlayingWidget extends StatelessWidget {
  const SearchListNowPlayingWidget(
      {super.key, required this.nowPlaying, required this.configuration});

  final List<Movie> nowPlaying;
  final Configuration configuration;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: nowPlaying.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Get.toNamed(ConfigRoute.aboutSessionsPage,
              arguments: nowPlaying[index]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  constraints:
                      const BoxConstraints(minHeight: 100, maxWidth: 80),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${configuration.getPosterUrl(nowPlaying[index].posterPath, size: PosterSize.w500)}"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(nowPlaying[index].title,
                        style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: 4),
                    CustomText(
                        text: nowPlaying[index].overview,
                        overflow: TextOverflow.ellipsis,
                        collapsedMaxLines: 2,
                        textAlign: TextAlign.justify,
                        isExpandable: false,
                        customStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColor.primaryIconColor)),
                    SizedBox(height: 4),
                    Text(
                        FormatDateTime.convertFromYYYYMMDDToDDMMYYYY(
                                nowPlaying[index].releaseDate)
                            .toString(),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
