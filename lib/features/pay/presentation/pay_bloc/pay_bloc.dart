import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/pay/domain/enum/pay_enum.dart';
import 'package:vinemas_v1/features/pay/domain/use_case/payment_use_case.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/use_case/ticket_use_case.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayInitial()) {
    on<PayEvent>((event, emit) {});
    on<PaymentTicketEvent>(paymentTicket);
    on<RefundTicketEvent>(refundTicket);
    on<PaymentTicketChangeShowTimeEvent>(paymentTicketChangeShowTime);
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
              processStatus: ProcessStatus.success,
              ticket: ticket,
              message: message));
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

  Future<void> refundTicket(
      RefundTicketEvent event, Emitter<PayState> emit) async {
    try {
      emit(PaymentTicketState(processStatus: ProcessStatus.loading));

      TicketModel ticketModel = event.ticketModel.copyWith(
          sessionId: event.ticketModel.sessionId,
          seats: event.ticketModel.seats,
          totalPrice: event.ticketModel.totalPrice,
          status: TicketStatus.pending,
          bookedTime: event.ticketModel.bookedTime);

      await getIt<PaymentUseCase>().refundTicket(
        amount: event.amount,
        currency: event.currency,
        paymentMethod: event.payMethodEnum,
        ticket: ticketModel,
      );

      await getIt<TicketUseCase>().updateBookTicket(
        ticket: ticketModel.copyWith(
          ticketId: ticketModel.ticketId,
          status: TicketStatus.cancelled,
        ),
        onPressed: ({required message, required status}) {
          emit(PaymentTicketState(
              processStatus: ProcessStatus.success, message: message));
        },
      );

      Map<String, ChairStatus> chairStatus =
          Map.from(event.sessionMovie.chairStatuses)
            ..removeWhere((key, value) => ticketModel.seats.contains(key));

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

  Future<void> paymentTicketChangeShowTime(
      PaymentTicketChangeShowTimeEvent event, Emitter<PayState> emit) async {
    try {
      emit(PaymentTicketState(processStatus: ProcessStatus.loading));

      // Lấy danh sách session movie
      List<SessionMovie> sessionMovies = [];
      await getIt<SessionUseCase>().getSessionMovie(
        onPressed: (
            {required message, required sessionMovie, required status}) {
          sessionMovies = sessionMovie ?? [];
        },
      );

      // Tìm session cũ
      final sessionOld = sessionMovies.firstWhereOrNull(
          (element) => element.sessionMovieId == event.ticketModel.sessionId);
      if (sessionOld == null) {
        throw Exception("Không tìm thấy session cũ.");
      }

      // Cập nhật trạng thái ghế trong session cũ (xoá ghế đã đặt)
      final updatedOldChairStatuses = Map<String, ChairStatus>.from(
          sessionOld.chairStatuses)
        ..removeWhere((key, value) => event.ticketModel.seats.contains(key));

      await _updateSessionMovie(sessionOld, updatedOldChairStatuses);

      // Tạo TicketModel mới với session mới
      final updatedTicket = event.ticketModel.copyWith(
        sessionId: event.sessionMovie.sessionMovieId,
        seats: event.seats,
        totalPrice: event.ticketModel.totalPrice,
        status: TicketStatus.active,
        bookedTime: DateTime.now(),
        updateTime: DateTime.now(),
      );

      // Thanh toán vé mới
      await getIt<PaymentUseCase>().paymentTicket(
        amount: event.amount,
        currency: event.currency,
        paymentMethod: event.payMethodEnum,
        ticket: updatedTicket,
      );

      // Cập nhật thông tin vé mới
      await getIt<TicketUseCase>().updateBookTicket(
        ticket: updatedTicket,
        onPressed: ({required message, required status}) {
          emit(PaymentTicketState(
              processStatus: ProcessStatus.success,
              ticket: updatedTicket,
              message: message));
        },
      );

      // Cập nhật trạng thái ghế trong session mới (đánh dấu ghế đã đặt)
      final updatedNewChairStatuses =
          Map<String, ChairStatus>.from(event.sessionMovie.chairStatuses);
      for (String seat in event.seats) {
        updatedNewChairStatuses[seat] = ChairStatus.booked;
      }

      await _updateSessionMovie(event.sessionMovie, updatedNewChairStatuses);
    } catch (e, stacktrace) {
      printE("Error: $e\nStacktrace: $stacktrace");
      emit(PaymentTicketState(
          processStatus: ProcessStatus.failure, message: e.toString()));
    }
  }

  /// Hàm cập nhật session movie
  Future<void> _updateSessionMovie(
      SessionMovie session, Map<String, ChairStatus> chairStatuses) async {
    final updatedSession = session.copyWith(chairStatuses: chairStatuses);
    await getIt<SessionUseCase>()
        .updateSessionMovie(sessionMovie: updatedSession);
  }
}
