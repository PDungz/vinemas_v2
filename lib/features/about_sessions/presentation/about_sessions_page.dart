import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Page_view/custom_page_view.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/page/about_page.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/page/sessions_page.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about_sessions_app_bar_widget.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';

class AboutSessionsPage extends StatefulWidget {
  const AboutSessionsPage({super.key});

  @override
  State<AboutSessionsPage> createState() => _AboutSessionsPageState();
}

class _AboutSessionsPageState extends State<AboutSessionsPage> {
  int _selectedTabIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    AboutPage(
      movie: Get.arguments as Movie,
    ),
    const SessionsPage(),
  ];

  void _onTabSelected(int index) {
    setState(() => _selectedTabIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Movie parameter = Get.arguments as Movie;

    return CustomLayout(
      appBar: AboutSessionsAppBarWidget(
          parameter: parameter,
          selectedTabIndex: _selectedTabIndex,
          pageController: _pageController,
          onTabSelected: _onTabSelected),
      // bottomNavigationBar: CustomCard(
      //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      //   borderRadius: BorderRadius.circular(0.0),
      //   backgroundColor: AppColor.secondaryColor,
      //   child: CustomShadow(
      //     child: CustomButton(
      //         label: AppLocalizations.of(context)!.keyword_select_session,
      //         onPressed: () {}),
      //   ),
      // ),
      body: CustomPageView(
        controller: _pageController,
        pages: _pages,
        onPageChanged: (index) {
          setState(() => _selectedTabIndex = index);
        },
        showIndicator: false,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
