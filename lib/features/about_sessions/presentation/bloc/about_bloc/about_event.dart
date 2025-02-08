// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'about_bloc.dart';

abstract class AboutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailEvent extends AboutEvent {
  final int movieId;
  MovieDetailEvent({
    required this.movieId,
  });
}
