import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/common/extension/seat_extenstion.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SeatReservationListTitleSeatWidget extends StatelessWidget {
  const SeatReservationListTitleSeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _buildItemSeat(
              context: context,
              seatColor: SeatTypeEnum.reserved.color,
              titleItem: SvgPicture.asset($AssetsIconsGen().iconApp.close),
              seat: AppLocalizations.of(context)!.keyword_seat_reserved),
          _buildItemSeat(
              context: context,
              seatColor: SeatTypeEnum.selected.color,
              seat: AppLocalizations.of(context)!.keyword_seat_selected),
          _buildItemSeat(
              context: context,
              seatColor: SeatTypeEnum.regular.color,
              seat: AppLocalizations.of(context)!.keyword_seat_regular),
          _buildItemSeat(
            context: context,
            seatColor: SeatTypeEnum.vip.color,
            seat: AppLocalizations.of(context)!.keyword_seat_vip,
          ),
          _buildItemSeat(
            context: context,
            seatColor: SeatTypeEnum.sweetbox.color,
            seat: AppLocalizations.of(context)!.keyword_seat_sweetbox,
          ),
        ],
      ),
    );
  }
}

Widget _buildItemSeat(
        {required BuildContext context,
        Widget? titleItem,
        required Color seatColor,
        String? seat}) =>
    CustomLayoutHorizontal(
      horizontalPadding: 8,
      leftWidget: Container(
        margin: EdgeInsets.only(right: 8),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: titleItem ?? SizedBox(),
      ),
      rightWidget:
          Text(seat ?? '', style: Theme.of(context).textTheme.titleSmall),
    );
