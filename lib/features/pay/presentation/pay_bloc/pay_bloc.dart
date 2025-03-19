import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/use_case/payment_use_case.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/use_case/ticket_use_case.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayInitial()) {
    on<PayEvent>((event, emit) {});
    on<PaymentTicketEvent>(paymentTicket);
  }

  Future<void> paymentTicket(
      PaymentTicketEvent event, Emitter<PayState> emit) async {
    try {
      emit(PaymentTicketState(processStatus: ProcessStatus.loading));

      TicketModel ticketModel = event.ticketModel.copyWith(
          sessionId: event.ticketModel.sessionId,
          seats: event.ticketModel.seats,
          totalPrice: event.ticketModel.totalPrice,
          status: TicketStatus.pending,
          bookedTime: event.ticketModel.bookedTime);

      final ticket = await getIt<TicketUseCase>().bookTicket(
        ticket: ticketModel,
        onPressed: ({required message, required status}) {
          // emit(PaymentTicketState(
          //     processStatus: ProcessStatus.success, message: message));
        },
      );

      await getIt<PaymentUseCase>().paymentTicket(
        amount: event.amount,
        currency: event.currency,
        paymentMethod: event.payMethodEnum,
        ticket: ticket!,
      );

      await getIt<TicketUseCase>().updateBookTicket(
        ticket: ticketModel.copyWith(
          ticketId: ticket.ticketId,
          status: TicketStatus.active,
        ),
        onPressed: ({required message, required status}) {
          emit(PaymentTicketState(
              processStatus: ProcessStatus.success, message: message));
        },
      );

      Map<String, ChairStatus> chairStatus = event.sessionMovie.chairStatuses;

      for (var seat in event.ticketModel.seats) {
        chairStatus[seat] = ChairStatus.booked;
      }

      SessionMovie sessionMovie =
          event.sessionMovie.copyWith(chairStatuses: chairStatus);

      await getIt<SessionUseCase>()
          .updateSessionMovie(sessionMovie: sessionMovie);
    } catch (e) {
      printE("Error: $e");
      emit(PaymentTicketState(
          processStatus: ProcessStatus.failure, message: e.toString()));
    }
  }
}
