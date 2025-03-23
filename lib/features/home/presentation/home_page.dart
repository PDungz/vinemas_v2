import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Shadow/custom_shadow.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/home_app_bar_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/home_body_widget.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpcomingBloc>(
          create: (context) => UpcomingBloc()..add(UpcomingLoadEvent()),
        ),
        BlocProvider<NowPlayingBloc>(
          create: (context) => NowPlayingBloc()
            ..add(NowPlayingLoadMoreEvent(movie: [], page: 1)),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(isUserLoggedInEvent()),
        ),
        BlocProvider<SessionBloc>(
          create: (context) => SessionBloc(),
        ),
      ],
      child: CustomLayout(
        appBar: HomeAppBarWidget(),
        body: HomeBodyWidget(),
        overlayWidget: GestureDetector(
          onTap: () => Get.toNamed(ConfigRoute.chatBotPage),
          child: CustomShadow(
            child: Card(
              color: AppColor.buttonLinerOneColor,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  $AssetsIconsGen().iconApp.chat,
                  height: 32.0,
                  // ignore: deprecated_member_use
                  color: AppColor.primaryTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
