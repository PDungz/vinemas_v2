import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:vinemas_v1/features/home/presentation/widget/home_app_bar_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/home_body_widget.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';

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
      ],
      child: CustomLayout(
        appBar: HomeAppBarWidget(),
        body: HomeBodyWidget(),
      ),
    );
  }
}
