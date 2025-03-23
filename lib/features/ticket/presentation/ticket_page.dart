import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/ticket/presentation/bloc/ticket_bloc.dart';
import 'package:vinemas_v1/features/ticket/presentation/widget/ticket_app_bar_widget.dart';
import 'package:vinemas_v1/features/ticket/presentation/widget/ticket_item_detail_widget.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketBloc()..add(TicketMovieEvent()),
      child: CustomLayout(
        appBar: TicketAppBarWidget(
          title: AppLocalizations.of(context)!.keyword_tickets,
          showIconTicket: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 68, right: 12, left: 12),
          child: BlocBuilder<TicketBloc, TicketState>(
            builder: (context, state) {
              if (state is TicketMovieState) {
                switch (state.processStatus) {
                  case ProcessStatus.loading:
                    return TicketListItemLoadingWidget();
                  case ProcessStatus.success:
                    final tickets = state.tickets ?? [];
                    return ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return TicketItemDetailWidget(ticket: tickets[index]);
                      },
                    );
                  default:
                    return const TicketListItemLoadingWidget();
                }
              }
              return TicketListItemLoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}

class TicketListItemLoadingWidget extends StatelessWidget {
  const TicketListItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: AppColor.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CustomShimmer(
                width: 68,
                height: 108,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomShimmer(
                          width: 100,
                          height: 20,
                          borderRadius: 8,
                          baseColor:
                              AppColor.secondaryTextColor.withOpacity(0.3),
                          highlightColor:
                              AppColor.buttonLinerOneColor.withOpacity(0.6),
                        ),
                        CustomShimmer(
                          width: 54,
                          height: 24,
                          borderRadius: 8,
                          baseColor:
                              AppColor.secondaryTextColor.withOpacity(0.3),
                          highlightColor:
                              AppColor.buttonLinerOneColor.withOpacity(0.6),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomShimmer(
                      width: 160,
                      height: 20,
                      borderRadius: 8,
                      baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                      highlightColor:
                          AppColor.buttonLinerOneColor.withOpacity(0.6),
                    ),
                    const SizedBox(height: 10),
                    CustomShimmer(
                      width: 200,
                      height: 20,
                      borderRadius: 8,
                      baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                      highlightColor:
                          AppColor.buttonLinerOneColor.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
