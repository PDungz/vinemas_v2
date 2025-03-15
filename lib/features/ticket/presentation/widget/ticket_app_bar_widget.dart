import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packages/widget/App_bar/custom_app_bar.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:vinemas_v1/core/config/app_router.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class TicketAppBarWidget extends StatelessWidget {
  const TicketAppBarWidget({
    super.key,
    required this.title,
    this.showIconTicket = true,
  });

  final String title;
  final bool showIconTicket;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        svgPathUp: $AssetsIconsGen().iconApp.back,
        onPressed: () => Get.back(),
        elevation: 0,
      ),
      title: Padding(
        padding: EdgeInsets.only(
            top: 12.0, bottom: 12.0, right: showIconTicket ? 0 : 36),
        child: Text(title,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
      ),
      actions: [
        if (showIconTicket)
          CustomIconButton(
              elevation: 0,
              svgPathUp: $AssetsIconsGen().iconApp.ticket,
              onPressed: () {
                Get.toNamed(ConfigRoute.ticketPage);
              })
      ],
    );
  }
}
