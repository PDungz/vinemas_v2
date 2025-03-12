import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/features/pay/domain/use_case/payment_use_case.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/use_case/ticket_use_case.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketEvent>((event, emit) {});
  }

  Future<void> getTicketMoves(
      TicketMovieEvent event, Emitter<TicketState> emit) async {
    try {
      emit(TicketMovieState(processStatus: ProcessStatus.loading));

      final ticketMovies = await getIt<TicketUseCase>().getTickets();

      emit(TicketMovieState(
          tickets: ticketMovies,
          processStatus: ProcessStatus.success,
          message: 'Successful TicketMovies'));
    } catch (e) {
      emit(TicketMovieState(
          processStatus: ProcessStatus.failure,
          message: 'Failure TicketMovies'));
    }
  }

  Future<void> getUserTicketMove(
      UserMovieTicketEvent event, Emitter<TicketState> emit) async {
    try {
      emit(SeatMovieTicketState(processStatus: ProcessStatus.loading));

      final payment = await getIt<PaymentUseCase>().getUserPaymentTicket();
      final ticketMovies = await getIt<TicketUseCase>().getTickets();

      // Lấy danh sách paymentId từ giao dịch đã thanh toán (đã lọc theo user trước đó)
      final List<String> paidPaymentIds =
          payment.map((p) => p?.paymentId ?? '').toList();

      // Lọc danh sách ticket theo paymentId và sessionMovieId
      final List<Ticket> filteredTickets = ticketMovies!
          .where((t) =>
              paidPaymentIds.contains(t.paymentId) &&
              t.sessionId == event.sessionMovieId)
          .toList();

      // Lấy danh sách ghế đã đặt
      final List<String> bookedSeats =
          filteredTickets.expand((t) => t.seats).toList();

      emit(SeatMovieTicketState(
          seats: bookedSeats,
          processStatus: ProcessStatus.success,
          message: 'Successful TicketMovies'));
    } catch (e) {
      emit(SeatMovieTicketState(
          processStatus: ProcessStatus.failure,
          message: 'Failure TicketMovies'));
    }
  }
}
