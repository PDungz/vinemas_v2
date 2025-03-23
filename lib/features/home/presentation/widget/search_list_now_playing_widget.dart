import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:packages/widget/Text/custom_text.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/common/extension/genres_extension.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/container/widget/network_image_empty_widget.dart';
import 'package:vinemas_v1/core/global/api/configuration/domain/entity/configuration.dart';
import 'package:vinemas_v1/core/global/api/genres/domain/entity/genres.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SearchListNowPlayingWidget extends StatelessWidget {
  const SearchListNowPlayingWidget(
      {super.key,
      required this.nowPlaying,
      required this.configuration,
      required this.genres});

  final List<Movie> nowPlaying;
  final Configuration configuration;
  final List<Genres> genres;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: nowPlaying.length,
      itemBuilder: (context, index) {
        final listGenreName =
            genres.convertGenreIdsToNames(nowPlaying[index].genreIds);
        return GestureDetector(
          onTap: () {
            context
                .read<SessionBloc>()
                .add(CreatSessionCinemaEvent(movie: nowPlaying[index]));

            Get.toNamed(ConfigRoute.aboutSessionsPage,
                arguments: nowPlaying[index]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: NetworkImageEmptyWidget(
                  posterImgPath:
                      "${configuration.getPosterUrl(nowPlaying[index].posterPath, size: PosterSize.w500)}",
                  minHeight: 100,
                  maxWidth: 80,
                ).marginSymmetric(vertical: 4),
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
                    CustomLayoutLabelValue(
                      labelWidth: 60,
                      padding: EdgeInsets.zero,
                      widgetLeft: Text(
                          AppLocalizations.of(context)!.keyword_release,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColor.secondaryTextColor)),
                      widgetRight: Text(
                          FormatDateTime.convertFromYYYYMMDDToDDMMYYYY(
                                  nowPlaying[index].releaseDate)
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColor.primaryIconColor)),
                    ),
                    CustomLayoutLabelValue(
                      padding: EdgeInsets.zero,
                      labelWidth: 60,
                      widgetLeft: Text(
                        AppLocalizations.of(context)!.keyword_genre,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.secondaryTextColor,
                            ),
                      ),
                      widgetRight: CustomText(
                          text: listGenreName.join(', '),
                          overflow: TextOverflow.ellipsis,
                          collapsedMaxLines: 1,
                          textAlign: TextAlign.justify,
                          isExpandable: false,
                          customStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColor.primaryIconColor)),
                    ),
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
