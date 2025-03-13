import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Dialog/custom_dialog.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Page_view/custom_page_view.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/page/about_page.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/page/sessions_page.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/about/about_sessions_app_bar_widget.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class AboutSessionsPage extends StatefulWidget {
  const AboutSessionsPage({super.key});

  @override
  State<AboutSessionsPage> createState() => _AboutSessionsPageState();
}

class _AboutSessionsPageState extends State<AboutSessionsPage> {
  int _selectedTabIndex = 0;
  late final Movie parameter;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _getArguments();
  }

  void _getArguments() {
    final dynamic args = Get.arguments;

    if (args is Movie) {
      parameter = args;
    } else if (args is List && args.isNotEmpty && args.first is Movie) {
      parameter = args.first as Movie;
    } else {
      throw Exception("Invalid argument type: $args");
    }
  }

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
    // final Movie parameter = Get.arguments as Movie;

    return BlocProvider(
      create: (context) => UserBloc()..add(isUserLoggedInEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return CustomLayout(
            appBar: AboutSessionsAppBarWidget(
                parameter: parameter,
                selectedTabIndex: _selectedTabIndex,
                pageController: _pageController,
                onTabSelected: (int index) {
                  if (state is isUserLoggedInState &&
                      state.isUserLoggedIn == true) {
                    _onTabSelected(index);
                  } else {
                    Get.dialog(CustomDialog(
                      title: AppLocalizations.of(context)!.keyword_notification,
                      description: AppLocalizations.of(context)!
                          .keyword_notification_login_required,
                      acceptText: AppLocalizations.of(context)!.keyword_confirm,
                      cancelText: AppLocalizations.of(context)!.keyword_cancel,
                      onAccept: () {
                        Get.toNamed(ConfigRoute.loginPage);
                      },
                    ));
                  }
                }),
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
            body: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return CustomPageView(
                  controller: _pageController,
                  pages: [
                    AboutPage(
                        movie: parameter,
                        onSelectSession: () =>
                            _onTabSelected(1)), // Truyền callback vào
                    SessionsPage(movie: parameter),
                  ],
                  onPageChanged: (index) {
                    setState(() => _selectedTabIndex = index);
                  },
                  showIndicator: false,
                  physics: const NeverScrollableScrollPhysics(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
