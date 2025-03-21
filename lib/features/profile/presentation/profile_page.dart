import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/features/login/presentation/bloc/bloc/user_bloc.dart';
import 'package:vinemas_v1/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:vinemas_v1/features/profile/presentation/widget/history_ticket_widget.dart';
import 'package:vinemas_v1/features/profile/presentation/widget/profile_app_bar_widget.dart';
import 'package:vinemas_v1/features/profile/presentation/widget/profile_avatar_widget.dart';
import 'package:vinemas_v1/features/profile/presentation/widget/profile_form_info_widget.dart';
import 'package:vinemas_v1/features/profile/presentation/widget/setting_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: CustomLayout(
        appBar: ProfileAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
            child: ListView(
              children: [
                ProfileAvatarWidget(),
                SizedBox(height: 20),
                ProfileFormInfoWidget(),
                SizedBox(height: 8),
                SettingWidget(),
                  SizedBox(height: 8),
                HistoryTicketWidget(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
