import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/features/home/presentation/widget/movie_item_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/upcoming_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key});

  final listUpcommingMoviesPoster = [
    "https://i.ebayimg.com/images/g/4v4AAOSwa39fz003/s-l1200.jpg",
    "https://rukminim2.flixcart.com/image/850/1000/k5wse4w0/poster/u/b/a/medium-artistic-movie-poster-thor-marvel-movie-poster-for-room-original-imafzgvb2xt8ptzx.jpeg?q=90&crop=false",
    "https://townsquare.media/site/442/files/2017/10/thor_ragnarok_ver2_xlg1.jpg?w=780&q=75",
    "https://townsquare.media/site/442/files/2017/10/thor_ragnarok_ver2_xlg1.jpg?w=780&q=75",
    "https://rukminim2.flixcart.com/image/850/1000/k5wse4w0/poster/u/b/a/medium-artistic-movie-poster-thor-marvel-movie-poster-for-room-original-imafzgvb2xt8ptzx.jpeg?q=90&crop=false",
    "https://townsquare.media/site/442/files/2017/10/thor_ragnarok_ver2_xlg1.jpg?w=780&q=75",
    "https://static.wixstatic.com/media/c0ca52_861cbfbd84344362a233f609406354cd~mv2.jpg/v1/fill/w_540,h_675,al_c,q_85,enc_auto/c0ca52_861cbfbd84344362a233f609406354cd~mv2.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 80,
          ),
        ),
        SliverToBoxAdapter(
          child: UpcomingWidget(
              listUpcommingMoviesPoster: listUpcommingMoviesPoster),
        ),
        SliverToBoxAdapter(
          child: CustomLayoutHorizontal(
            crossAxisAlignment: CrossAxisAlignment.center,
            leftWidget: Text(
              AppLocalizations.of(context)!.keyword_now_in_cinemas,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            rightWidget: InkWell(
              onTap: () {
                CustomBottomSheet.show(context, body: Container());
              },
              child: SvgPicture.asset($AssetsIconsGen().iconApp.search),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          sliver: SliverGrid.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.56,
            ),
            itemBuilder: (_, index) => MovieItemWidget(
              posterImgPath: listUpcommingMoviesPoster[index],
              title: "Movie $index",
              genre: "Action",
              score: 8.2,
            ),
          ),
        ),
      ],
    );
  }
}
