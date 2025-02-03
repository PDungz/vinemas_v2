import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialNetworkWidget extends StatelessWidget {
  final String socialNetworkWidget;
  final String title;
  final void Function()? onTap;

  const SocialNetworkWidget({
    super.key,
    required this.socialNetworkWidget,
    required this.title,
    this.onTap,
  });
   
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            socialNetworkWidget,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}
