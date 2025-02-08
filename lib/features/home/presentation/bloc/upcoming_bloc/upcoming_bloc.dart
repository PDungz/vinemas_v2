import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinemas_v1/core/common/enum/status_state.dart';
import 'package:vinemas_v1/core/service/injection_container.dart';
import 'package:vinemas_v1/core/service/logger_service.dart';
import 'package:vinemas_v1/features/home/domain/entity/movie.dart';
import 'package:vinemas_v1/features/home/domain/use_case/upcoming_use_case.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  UpcomingBloc() : super(UpcomingInitial()) {
    on<UpcomingEvent>(getUpcoming);
  }

  Future<void> getUpcoming(
      UpcomingEvent event, Emitter<UpcomingState> emit) async {
    try {
      emit(UpcomingLoadedState(state: StatusState.loading));
      final List<Movie>? upcoming =
          await getIt<UpcomingUseCase>().getUpcoming();
      emit(UpcomingLoadedState(
        state: StatusState.success,
        upcoming: upcoming ?? [],
      ));
    } catch (e) {
      printE("[Get Upcoming Bloc] error: $e");
      emit(UpcomingLoadedState(
        state: StatusState.failure,
        errorMsg: e.toString(),
      ));
    }
  }
}
