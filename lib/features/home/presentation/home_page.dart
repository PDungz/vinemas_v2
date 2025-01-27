import 'package:flutter/material.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/features/home/presentation/widget/app_bar_widget.dart';
import 'package:vinemas_v1/features/home/presentation/widget/body_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: AppBarWidget(),
      body: BodyWidget(),
    );
  }
}
