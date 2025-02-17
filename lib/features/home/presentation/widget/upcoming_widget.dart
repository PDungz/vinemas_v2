import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Carousel/custom_carousel.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/core/common/enum/configuration.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/extension/configuration_extension.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, homeState) {
          if (homeState is UpcomingLoadedState) {
            switch (homeState.state) {
              case ProcessStatus.loading:
                return _buildUpcomingWidget(
                  context: context,
                  isLoading: true,
                  listMovie: <Movie>[],
                  listUpcommingMoviesPoster: <String>[],
                );
              case ProcessStatus.success:
                final upcomingPoster = homeState.upcoming;
                return BlocBuilder<GlobalBloc, GlobalState>(
                  builder: (_, globalState) {
                    final configuration = globalState.configuration;
                    if (upcomingPoster != null && configuration != null) {
                      final listUpcomingMoviesPoster = upcomingPoster
                          .map((e) =>
                              "${configuration.getPosterUrl(e.posterPath, size: PosterSize.w342)}")
                          .toList();
                      return _buildUpcomingWidget(
                        context: context,
                        listMovie: upcomingPoster,
                        listUpcommingMoviesPoster: listUpcomingMoviesPoster,
                        isLoading: false,
                      );
                    }
                    return const SizedBox();
                  },
                );
              case ProcessStatus.failure:
                return Center(child: Text("Error: ${homeState.errorMsg}"));
              case ProcessStatus.idle:
              default:
                return const SizedBox();
            }
          }
          return const SizedBox();
        },
      );
}

Widget _buildUpcomingWidget({
  required BuildContext context,
  required bool isLoading,
  required List<String> listUpcommingMoviesPoster,
  required List<Movie> listMovie,
}) =>
    CustomLayoutVertical(
      verticalPadding: 0,
      horizontalPadding: 0,
      topWidget: CustomLayoutHorizontal(
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalPadding: 0,
        leftWidget: Text(
          AppLocalizations.of(context)!.keyword_upcoming,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        rightWidget: GestureDetector(
          onTap: () {},
          child: Text(
            AppLocalizations.of(context)!.keyword_view_all,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.primaryIconColor,
                ),
          ),
        ),
      ),
      bottomWidget: CustomCarousel<Movie>(
        isLoading: isLoading,
        onTap: ({required Movie parameter}) {
          Get.toNamed(ConfigRoute.aboutSessionsPage, arguments: parameter);
        },
        listItem: listMovie,
        listUrlImage: listUpcommingMoviesPoster,
      ),
    );
