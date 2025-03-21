import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/common/enum/seat_enum.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/about/movie_detail.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/chair_config.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/session_movie.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/about/movie_detail_use_case.dart';
import 'package:vinemas_v1/features/about_sessions/domain/use_case/session/session_use_case.dart';
import 'package:vinemas_v1/features/pay/domain/use_case/payment_use_case.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/enum/ticket_status_enum.dart';
import 'package:vinemas_v1/features/ticket/domain/use_case/ticket_use_case.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketMovieEvent>(getTicketMoves);
    on<UserMovieTicketEvent>(getUserTicketMoveSeat);
    on<TicketMovieDetailEvent>(getTicketDetailMoves);
    on<ChangeTichetEvent>(changeTicket);
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
      final List<String> bookTicketId = payment
          .where((p) =>
              p?.ticketId != null) // Loại bỏ phần tử null hoặc ticketId null
          .map((p) => p!.ticketId) // Lấy ticketId
          .toList();

      // Lọc danh sách ticket theo paymentId và sessionMovieId
      final List<Ticket> filteredTickets = ticketMovies
          .where((t) => bookTicketId.contains(t.ticketId)) // Kiểm tra sessionId
          .toList()
        ..sort(
          (a, b) => b.bookedTime.compareTo(a.bookedTime),
        );

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

      List<ChairConfig> chairConfigs = [];
      await getIt<SessionUseCase>().getChairConfig(
        onPressed: ({required chairConfig, required message, required status}) {
          chairConfigs = chairConfig ?? [];
        },
      );

      final sessionMovie = await getIt<SessionUseCase>()
          .getSessionMovieDetail(sessionMovieId: event.ticket.sessionId);

      final cinema = await getIt<SessionUseCase>()
          .getCinemaDetail(cinemaId: sessionMovie?.cinemaId ?? '');

      final movieDetail = await getIt<MovieDetailUseCase>()
          .getMovieDetail(movieId: sessionMovie?.movieId ?? -1);

      emit(MovieTicketDetailState(
          cinema: cinema,
          movieDetail: movieDetail,
          sessionMovie: sessionMovie,
          processStatus: ProcessStatus.success,
          chairConfig: chairConfigs.firstWhere(
            (element) => element.chairConfigId == cinema?.chairConfigId,
          ),
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
      final List<String> bookTicketId = payment
          .where((p) =>
              p?.ticketId != null) // Loại bỏ phần tử null hoặc paymentId null
          .map((p) => p!.ticketId) // Lấy paymentId
          .toList();

      // Lọc danh sách ticket theo paymentId và sessionMovieId
      final List<Ticket> filteredTickets = ticketMovies
          .where((t) =>
              bookTicketId.contains(t.ticketId) &&
              t.sessionId == event.sessionMovieId &&
              t.status == TicketStatus.active) // Kiểm tra sessionId
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

  Future<void> changeTicket(
      ChangeTichetEvent event, Emitter<TicketState> emit) async {
    try {
      emit(ChangeTicketState(processStatus: ProcessStatus.loading));

      List<SessionMovie> sessionMovies = [];
      await getIt<SessionUseCase>().getSessionMovie(
        onPressed: (
            {required message, required sessionMovie, required status}) {
          sessionMovies = sessionMovie ?? [];
        },
      );

      final sessionOld = sessionMovies.firstWhere(
          (element) => element.sessionMovieId == event.ticketModel.sessionId);

      Map<String, ChairStatus> chairStatus = Map.from(sessionOld.chairStatuses)
        ..removeWhere((key, value) => event.ticketModel.seats.contains(key));

      SessionMovie sessionMovieOld =
          sessionOld.copyWith(chairStatuses: chairStatus);

      await getIt<SessionUseCase>()
          .updateSessionMovie(sessionMovie: sessionMovieOld);

      TicketModel ticketModel = event.ticketModel.copyWith(
        sessionId: event.sessionMovie.sessionMovieId,
        seats: event.seats,
        totalPrice: event.ticketModel.totalPrice,
        status: TicketStatus.active,
        bookedTime: DateTime.now(),
        updateTime: DateTime.now(),
      );

      await getIt<TicketUseCase>().updateBookTicket(
        ticket: ticketModel,
        onPressed: ({required message, required status}) {
          emit(ChangeTicketState(
              processStatus: ProcessStatus.success, message: message));
        },
      );

      Map<String, ChairStatus> chairStatusNew =
          Map.from(event.sessionMovie.chairStatuses);
      for (String seat in event.seats) {
        chairStatusNew[seat] = ChairStatus.booked;
      }

      SessionMovie sessionMovieNew =
          event.sessionMovie.copyWith(chairStatuses: chairStatusNew);
      await getIt<SessionUseCase>()
          .updateSessionMovie(sessionMovie: sessionMovieNew);
    } catch (e) {
      printE("Error: $e");
      emit(ChangeTicketState(
          processStatus: ProcessStatus.failure, message: e.toString()));
    }
  }
}
