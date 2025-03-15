import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/pay/domain/entity/payment.dart';
import 'package:vinemas_v1/features/pay/domain/use_case/payment_use_case.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/use_case/ticket_use_case.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketMovieEvent>(getTicketMoves);
    on<UserMovieTicketEvent>(getUserTicketMoveSeat);
    on<TicketMovieDetailEvent>(getTicketDetailMoves);
  }

  Future<void> getTicketMoves(
      TicketMovieEvent event, Emitter<TicketState> emit) async {
    try {
      emit(TicketMovieState(processStatus: ProcessStatus.loading));

      // Lấy danh sách payment, đảm bảo không null
      final payment = await getIt<PaymentUseCase>().getUserPaymentTicket();

      // Lấy danh sách ticket, đảm bảo không null
      final ticketMovies = await getIt<TicketUseCase>().getTickets() ?? [];

      // Lấy danh sách paymentId từ giao dịch đã thanh toán
      final List<String> paidPaymentIds = payment
          .where((p) =>
              p?.paymentId != null) // Loại bỏ phần tử null hoặc paymentId null
          .map((p) => p!.paymentId) // Lấy paymentId
          .toList();

      // Lọc danh sách ticket theo paymentId và sessionMovieId
      final List<Ticket> filteredTickets = ticketMovies
          .where(
              (t) => paidPaymentIds.contains(t.paymentId)) // Kiểm tra sessionId
          .toList();

      emit(TicketMovieState(
          tickets: filteredTickets,
          processStatus: ProcessStatus.success,
          message: 'Successful TicketMovies'));
    } catch (e) {
      emit(TicketMovieState(
          processStatus: ProcessStatus.failure,
          message: 'Failure TicketMovies'));
    }
  }

  Future<void> getTicketDetailMoves(
      TicketMovieDetailEvent event, Emitter<TicketState> emit) async {
    try {
      emit(MovieTicketDetailState(processStatus: ProcessStatus.loading));

      // Lấy danh sách payment, đảm bảo không null
      final payment = await getIt<PaymentUseCase>()
          .getPayment(paymentId: event.ticket.paymentId);

      final sessionMovie = await getIt<SessionUseCase>()
          .getSessionMovieDetail(sessionMovieId: event.ticket.sessionId);

      final cinema = await getIt<SessionUseCase>()
          .getCinemaDetail(cinemaId: sessionMovie?.cinemaId ?? '');

      final movieDetail = await getIt<MovieDetailUseCase>()
          .getMovieDetail(movieId: sessionMovie?.movieId ?? -1);

      emit(MovieTicketDetailState(
          payment: payment,
          cinema: cinema,
          movieDetail: movieDetail,
          sessionMovie: sessionMovie,
          processStatus: ProcessStatus.success,
          message: 'Successful Ticket Detail'));
    } catch (e) {
      emit(MovieTicketDetailState(
          processStatus: ProcessStatus.failure,
          message: 'Failure Ticket Detail'));
    }
  }

  Future<void> getUserTicketMoveSeat(
      UserMovieTicketEvent event, Emitter<TicketState> emit) async {
    try {
      emit(SeatMovieTicketState(processStatus: ProcessStatus.loading));

      // Lấy danh sách payment, đảm bảo không null
      final payment = await getIt<PaymentUseCase>().getUserPaymentTicket();

      // Lấy danh sách ticket, đảm bảo không null
      final ticketMovies = await getIt<TicketUseCase>().getTickets() ?? [];

      // Lấy danh sách paymentId từ giao dịch đã thanh toán
      final List<String> paidPaymentIds = payment
          .where((p) =>
              p?.paymentId != null) // Loại bỏ phần tử null hoặc paymentId null
          .map((p) => p!.paymentId) // Lấy paymentId
          .toList();

      // Lọc danh sách ticket theo paymentId và sessionMovieId
      final List<Ticket> filteredTickets = ticketMovies
          .where((t) =>
              paidPaymentIds.contains(t.paymentId) &&
              t.sessionId == event.sessionMovieId) // Kiểm tra sessionId
          .toList();

      // Lấy danh sách ghế đã đặt
      final List<String> bookedSeats = filteredTickets
          .expand((t) => t.seats) // Đảm bảo seats không null
          .toList();

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
