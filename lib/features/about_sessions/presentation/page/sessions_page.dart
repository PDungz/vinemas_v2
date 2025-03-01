import 'package:flutter/material.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/widget/sessions_header_widget.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SessionsHeaderWidget(),
      ],
    );
  }
}
