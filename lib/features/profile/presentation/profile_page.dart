import 'package:flutter/material.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/features/profile/presentation/widget/profile_app_bar_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(appBar: ProfileAppBarWidget(), body: Container());
  }
}
