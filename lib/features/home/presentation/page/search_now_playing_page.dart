// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/core/utils/format_datetime.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/filter_search_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/search_list_now_playing_loading.dart';
import 'package:vinemas_v1/features/home/presentation/widget/search_list_now_playing_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SearchNowPlayingPage extends StatefulWidget {
  const SearchNowPlayingPage({super.key});

  @override
  State<SearchNowPlayingPage> createState() => _SearchNowPlayingPageState();
}

class _SearchNowPlayingPageState extends State<SearchNowPlayingPage> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _showScrollToTopButton = false;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  late bool isShowFilter;
  String dateFrom = '--/--/----';
  String dateTo = '--/--/----';
  List<int> selectedGenreIds = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    isShowFilter = false;
    super.initState();
  }

  _onGenresChanged(List<int> ids) {
    setState(() {
      selectedGenreIds = ids;
    });
  }

  _getDateForm(String value) {
    setState(() {
      dateFrom = value;
    });
  }

  _getDateTo(String value) {
    setState(() {
      dateTo = value;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final currentState = context.read<NowPlayingBloc>().state;

      if (currentState is NowPlayingSearchLoadedState &&
          !currentState.loadingMore) {
        final nextPage = _currentPage + 1;
        context.read<NowPlayingBloc>().add(
              NowPlayingSearchLoadMoreEvent(
                movie: currentState.nowPlaying ?? [],
                page: nextPage,
              ),
            );
        _currentPage = nextPage;
      }
    }

    // Kiểm tra vị trí cuộn để hiển thị nút
    if (_scrollController.offset > 300) {
      if (!_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      }
    } else {
      if (_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    }
  }

  _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayoutVertical(
      verticalPadding: 2,
      horizontalPadding: 2,
      topWidget: Container(
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.buttonLinerOneColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelColor: AppColor.primaryTextColor,
                hint: AppLocalizations.of(context)!.keyword_search,
                hintTextColor: AppColor.secondaryTextColor,
                svgPrefixIcon: $AssetsIconsGen().iconApp.search,
                controller: _searchController,
                focusNode: _searchFocusNode,
                borderType: BorderType.none,
                fillColor: AppColor.buttonLinerOneColor,
                primaryColor: AppColor.buttonLinerOneColor,
                textInputAction: TextInputAction.next,
                showClearButton: false,
                onChanged: (value) {
                  setState(() {
                    _searchController.text = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: CustomIconButton(
                verticalPadding: 4,
                horizontalPadding: 12,
                elevation: 0,
                svgPathUp: $AssetsIconsGen().iconApp.filterRegular,
                svgPathDown: $AssetsIconsGen().iconApp.filter,
                onPressed: () {
                  setState(() {
                    isShowFilter = !isShowFilter;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomWidget: BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, nowPlayingState) {
          return BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, globalState) {
              if (nowPlayingState is NowPlayingSearchLoadedState) {
                switch (nowPlayingState.state) {
                  case ProcessStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ProcessStatus.success:
                    final configuration = globalState.configuration;
                    final genres = globalState.genres;
                    List<Movie> nowPlaying = nowPlayingState.nowPlaying ?? [];

                    nowPlaying = nowPlaying.where((movie) {
                      final matchesKeyword = _searchController.text.isEmpty ||
                          removeDiacritics(movie.title.toLowerCase()).contains(
                              removeDiacritics(
                                  _searchController.text.toLowerCase()));

                      final matchesGenres = selectedGenreIds.isEmpty ||
                          movie.genreIds
                              .any((id) => selectedGenreIds.contains(id));

                      final movieReleaseDate =
                          DateTime.tryParse(movie.releaseDate);
                      final fromDate =
                          FormatDateTime.parseFromDDMMYYYY(dateFrom);
                      final toDate = FormatDateTime.parseFromDDMMYYYY(dateTo);

                      final matchesDateRange = (fromDate == null ||
                              movieReleaseDate!.isAfter(fromDate)) &&
                          (toDate == null ||
                              movieReleaseDate!.isBefore(toDate));

                      return matchesKeyword &&
                          matchesGenres &&
                          matchesDateRange;
                    }).toList();

                    return Expanded(
                      child: Stack(
                        children: [
                          Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            thickness: 4,
                            radius: const Radius.circular(8),
                            child: CustomScrollView(
                              controller: _scrollController,
                              primary: false,
                              physics: const BouncingScrollPhysics(),
                              slivers: [
                                if (isShowFilter)
                                  SliverToBoxAdapter(
                                    child: FilterSearchWidget(
                                      onGenresChanged: _onGenresChanged,
                                      getDateForm: _getDateForm,
                                      getDateTo: _getDateTo,
                                    ),
                                  ),
                                if (configuration != null)
                                  SliverPadding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 12, right: 12),
                                    sliver: SearchListNowPlayingWidget(
                                      configuration: configuration,
                                      genres: genres ?? [],
                                      nowPlaying: nowPlaying,
                                    ),
                                  ),
                                const SliverPadding(
                                    padding: EdgeInsets.only(bottom: 16)),
                                BlocBuilder<NowPlayingBloc, NowPlayingState>(
                                  builder: (context, state) {
                                    if (state is NowPlayingSearchLoadedState &&
                                        state.loadingMore) {
                                      return const SliverToBoxAdapter(
                                        child: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      );
                                    }
                                    return const SliverToBoxAdapter(
                                        child: SizedBox());
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (_showScrollToTopButton)
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: CustomIconButton(
                                onPressed: _scrollToTop,
                                backgroundColor: Theme.of(context).primaryColor,
                                horizontalPadding: 10,
                                iconColor: AppColor.primaryTextColor,
                                svgPathUp: $AssetsIconsGen().iconApp.angleUp,
                              ),
                            ),
                        ],
                      ),
                    );

                  default:
                    return const SizedBox();
                }
              }
              return Expanded(child: SearchListNowPlayingLoading());
            },
          );
        },
      ),
    );
  }
}
