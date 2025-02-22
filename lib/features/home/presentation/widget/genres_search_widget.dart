import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class GenresSearchWidget extends StatefulWidget {
  final Function(List<int>) onSelectedGenresChanged;

  const GenresSearchWidget({super.key, required this.onSelectedGenresChanged});

  @override
  State<GenresSearchWidget> createState() => _GenresSearchWidgetState();
}

class _GenresSearchWidgetState extends State<GenresSearchWidget> {
  bool isShowMore = false;
  List<int> selectedGenreIds = []; // Lưu danh sách ID đã chọn

  void _toggleGenreSelection(int genreId) {
    setState(() {
      if (selectedGenreIds.contains(genreId)) {
        selectedGenreIds.remove(genreId);
      } else {
        selectedGenreIds.add(genreId);
      }
    });
    widget.onSelectedGenresChanged(selectedGenreIds);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        final genres = state.genres;
        if (genres != null) {
          final displayedGenres = isShowMore ? genres : genres.take(5).toList();
          return Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: [
              ...displayedGenres.map((genre) {
                final isSelected = selectedGenreIds.contains(genre.id);
                return GestureDetector(
                  onTap: () => _toggleGenreSelection(genre.id),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: isSelected
                          ? null
                          : Border.all(
                              color: AppColor.primaryIconColor,
                              width: 1,
                            ),
                      color: isSelected
                          ? AppColor.buttonLinerOneColor
                          : AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      genre.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? AppColor.primaryTextColor
                                : AppColor.primaryIconColor,
                          ),
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isShowMore = !isShowMore;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isShowMore
                          ? Text(AppLocalizations.of(context)!.keyword_collapse,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColor.primaryIconColor))
                          : Text(AppLocalizations.of(context)!.keyword_more,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColor.primaryIconColor)),
                      const SizedBox(width: 4),
                      isShowMore
                          ? SvgPicture.asset(
                              $AssetsIconsGen().iconApp.angleUp,
                              height: 20,
                            )
                          : SvgPicture.asset(
                              $AssetsIconsGen().iconApp.expandArrow,
                              height: 20,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
