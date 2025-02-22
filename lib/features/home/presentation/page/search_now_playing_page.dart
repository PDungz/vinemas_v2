// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/Core/common/enum/text_form_field.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Text_field/custom_text_field.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/filter_search_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/search_list_now_playing_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SearchNowPlayingWidget extends StatefulWidget {
  const SearchNowPlayingWidget({super.key});

  @override
  State<SearchNowPlayingWidget> createState() => _SearchNowPlayingWidgetState();
}

class _SearchNowPlayingWidgetState extends State<SearchNowPlayingWidget> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _showScrollToTopButton = false;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late final TextEditingController _dateFromPickerController;
  late final FocusNode _dateFromPickerFocusNode;
  late final TextEditingController _dateToPickerController;
  late final FocusNode _dateToPickerFocusNode;
  late bool isShowFilter;
  List<int> selectedGenreIds = [];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _dateFromPickerController = TextEditingController();
    _dateFromPickerFocusNode = FocusNode();
    _dateToPickerController = TextEditingController();
    _dateToPickerFocusNode = FocusNode();
    super.initState();
  }

  _onGenresChanged(List<int> ids) {
    setState(() {
      selectedGenreIds = ids;
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
    _dateFromPickerController.dispose();
    _dateFromPickerFocusNode.dispose();
    _dateToPickerController.dispose();
    _dateToPickerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setStateBottomSheet) {
      return BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, nowPlayingState) {
          return BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, globalState) {
              if (nowPlayingState is NowPlayingSearchLoadedState) {
                switch (nowPlayingState.state) {
                  case ProcessStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ProcessStatus.success:
                    final configuration = globalState.configuration;
                    final nowPlaying = nowPlayingState.nowPlaying;
                    return CustomIconButton(
                      elevation: 0,
                      verticalPadding: 2,
                      svgPathUp: $AssetsIconsGen().iconApp.search,
                      onPressed: () {
                        setState(() {
                          isShowFilter = false;
                        });
                        CustomBottomSheet.show(
                          context,
                          minHeight: 0.68,
                          body: StatefulBuilder(
                            builder: (context, setStateBottomSheet) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColor.buttonLinerOneColor,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            labelColor:
                                                AppColor.primaryTextColor,
                                            hint: AppLocalizations.of(context)!
                                                .keyword_search,
                                            hintTextColor:
                                                AppColor.secondaryTextColor,
                                            svgPrefixIcon: $AssetsIconsGen()
                                                .iconApp
                                                .search,
                                            controller: _searchController,
                                            focusNode: _searchFocusNode,
                                            borderType: BorderType.none,
                                            fillColor:
                                                AppColor.buttonLinerOneColor,
                                            primaryColor:
                                                AppColor.buttonLinerOneColor,
                                            textInputAction:
                                                TextInputAction.next,
                                            showClearButton: true,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2.0),
                                          child: CustomIconButton(
                                            verticalPadding: 4,
                                            horizontalPadding: 12,
                                            elevation: 0,
                                            svgPathUp: $AssetsIconsGen()
                                                .iconApp
                                                .filterRegular,
                                            svgPathDown: $AssetsIconsGen()
                                                .iconApp
                                                .filter,
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
                                  SizedBox(height: 12),
                                  Expanded(
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
                                            physics:
                                                const BouncingScrollPhysics(),
                                            slivers: [
                                              if (isShowFilter)
                                                SliverToBoxAdapter(
                                                  child: FilterSearchWidget(
                                                    dateFromController:
                                                        _dateFromPickerController,
                                                    dateFromFocusNode:
                                                        _dateFromPickerFocusNode,
                                                    dateToController:
                                                        _dateToPickerController,
                                                    dateToFocusNode:
                                                        _dateToPickerFocusNode,
                                                    onGenresChanged:
                                                        _onGenresChanged,
                                                  ),
                                                ),
                                              if (configuration != null &&
                                                  nowPlaying != null)
                                                SliverPadding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          left: 12,
                                                          right: 12),
                                                  sliver:
                                                      SearchListNowPlayingWidget(
                                                          nowPlaying:
                                                              nowPlaying,
                                                          configuration:
                                                              configuration),
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
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              horizontalPadding: 10,
                                              iconColor:
                                                  AppColor.primaryTextColor,
                                              svgPathUp: $AssetsIconsGen()
                                                  .iconApp
                                                  .angleUp,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  default:
                    return const SizedBox();
                }
              }
              return SizedBox();
            },
          );
        },
      );
    });
  }
}
