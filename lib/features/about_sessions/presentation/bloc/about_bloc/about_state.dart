// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AboutInitial extends AboutState {}

class MovieDetailState extends AboutState {
  final ProcessStatus state;
  final MovieDetail? movieDetail;
  final List<Video>? video;
  final MovieCastCrew? movieCastCrew;
  final String? errorMsg;

  MovieDetailState({
    required this.state,
    this.movieDetail,
    this.video,
    this.movieCastCrew,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        state,
        movieDetail,
        video,
        movieCastCrew,
        errorMsg,
      ];

  MovieDetailState copyWith({
    ProcessStatus? state,
    MovieDetail? movieDetail,
    List<Video>? video,
    MovieCastCrew? movieCastCrew,
    String? errorMsg,
  }) {
    return MovieDetailState(
      state: state ?? this.state,
      movieDetail: movieDetail ?? this.movieDetail,
      video: video ?? this.video,
      movieCastCrew: movieCastCrew ?? this.movieCastCrew,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
