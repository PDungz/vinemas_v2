import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Layout/custom_layout.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
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
                    return const Center(child: CircularProgressIndicator());
                  case ProcessStatus.success:
                    final tickets = state.tickets ?? [];
                    return ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return TicketItemDetailWidget(ticket: tickets[index]);
                      },
                    );
                  default:
                    return const SizedBox();
                }
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
