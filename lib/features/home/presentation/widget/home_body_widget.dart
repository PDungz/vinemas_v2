import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/Core/config/app_color.dart';
import 'package:packages/widget/Bottom_sheet/custom_bottom_sheet.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/page/search_now_playing_page.dart';
import 'package:vinemas_v1/features/home/presentation/widget/now_playing_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/upcoming_widget.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class HomeBodyWidget extends StatefulWidget {
  const HomeBodyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeBodyWidgetState createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _showScrollToTopButton =
      false; // Biến để kiểm soát hiển thị nút cuộn lên

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final currentState = context.read<NowPlayingBloc>().state;

      if (currentState is NowPlayingLoadedState && !currentState.loadingMore) {
        final nextPage = _currentPage + 1;
        context.read<NowPlayingBloc>().add(
              NowPlayingLoadMoreEvent(
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

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            thickness: 4,
            radius: const Radius.circular(8),
            child: CustomScrollView(
              controller: _scrollController,
              primary: false,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
                const SliverToBoxAdapter(child: UpcomingWidget()),
                SliverToBoxAdapter(
                  child: CustomLayoutHorizontal(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    leftWidget: Text(
                      AppLocalizations.of(context)!.keyword_now_in_cinemas,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    rightWidget: CustomIconButton(
                      elevation: 0,
                      verticalPadding: 2,
                      svgPathUp: $AssetsIconsGen().iconApp.search,
                      onPressed: () {
                        CustomBottomSheet.show(context,
                            minHeight: 0.8,
                            body: BlocProvider<NowPlayingBloc>(
                              create: (context) => NowPlayingBloc()
                                ..add(NowPlayingSearchLoadMoreEvent(
                                    movie: [], page: 1)),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: SearchNowPlayingPage()),
                            ));
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12, right: 12),
                  sliver: NowPlayingWidget(),
                ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                BlocBuilder<NowPlayingBloc, NowPlayingState>(
                  builder: (context, state) {
                    if (state is NowPlayingLoadedState && state.loadingMore) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(child: SizedBox());
                  },
                ),
              ],
            ),
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
