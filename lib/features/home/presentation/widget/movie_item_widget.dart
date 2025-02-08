// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

class MovieItemWidget extends StatelessWidget {
  final Movie movie;
  final String posterImgPath;
  final String title;
  final String genres;
  final double score;
  const MovieItemWidget({
    super.key,
    required this.posterImgPath,
    required this.title,
    required this.genres,
    required this.score,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ConfigRoute.about_sessions_page, arguments: movie);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(minHeight: 230),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(posterImgPath), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: ScoreBadge(score: score),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            genres,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondaryTextColor,
                ),
          ),
        ],
      ),
    );
  }
}

class ScoreBadge extends StatelessWidget {
  final double score;
  const ScoreBadge({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final isLowScore = score < 7.0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: isLowScore
              ? const Color(0xff1F293D).withOpacity(.7)
              : const Color(0xffFF8036),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        score.toStringAsFixed(1),
        style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),
      ),
    );
  }
}
