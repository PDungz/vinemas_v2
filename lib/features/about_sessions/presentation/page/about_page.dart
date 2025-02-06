import 'package:flutter/material.dart';
import 'package:packages/widget/Layout/custom_layout_label_value.dart';
import 'package:packages/widget/Text/custom_text.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about_movie_rating.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
          "https://www.youtube.com/watch?v=Kp6WlyxBHBM")!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 108),
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            width: double.infinity,
            aspectRatio: 16 / 9,
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
            ),
            child: AboutMovieRating(imdb: '8.3', kinoposik: '8.6'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, left: 8, right: 8),
            child: CustomText(
              showTabIndent: true,
              text:
                  'When the Riddler, a sadistic serial killer, begins murdering '
                  'key political figures in Gotham, Batman is forced to '
                  'investigate the city\'s hidden corruption and question his family\'s involvement.',
              customStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColor.primaryTextColor,
                  ),
              collapsedMaxLines: 3,
              textAlign: TextAlign.justify,
              customStyleAction:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.buttonLinerOneColor,
                      ),
            ),
          ),
          SizedBox(height: 8),
          CustomLayoutLabelValue(
            label: AppLocalizations.of(context)!.keyword_certificate,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.secondaryTextColor,
                ),
            value: '16+',
          ),
          SizedBox(height: 8),
          CustomLayoutLabelValue(
            label: AppLocalizations.of(context)!.keyword_runtime,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.secondaryTextColor,
                ),
            value: '02:56',
          ),
          SizedBox(height: 8),
          CustomLayoutLabelValue(
            label: AppLocalizations.of(context)!.keyword_release,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.secondaryTextColor,
                ),
            value: '01/01/2025',
          ),
          SizedBox(height: 8),
          CustomLayoutLabelValue(
            label: AppLocalizations.of(context)!.keyword_genre,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.secondaryTextColor,
                ),
            value: 'Action, Crime, Drama, Animation, Comedy',
          ),
          SizedBox(height: 8),
          CustomLayoutLabelValue(
            label: AppLocalizations.of(context)!.keyword_director,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.secondaryTextColor,
                ),
            value: 'PHUNG VAN DUNG',
          ),
          SizedBox(height: 8),
          CustomLayoutLabelValue(
            label: AppLocalizations.of(context)!.keyword_cast,
            labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColor.secondaryTextColor,
                ),
            value:
                'Robert Pattinson, Zoë Kravitz, Jeffrey Wright, Colin Farrell, Paul Dano, John Turturro, 	Andy Serkis, Peter Sarsgaard',
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
