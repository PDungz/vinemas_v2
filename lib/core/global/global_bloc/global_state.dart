// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final ProcessStatus state;
  final Configuration? configuration;
  final List<Genres>? genres;
  final Locale? locale;
  final String? errorMsg;

  const GlobalState({
    this.state = ProcessStatus.idle,
    this.configuration,
    this.genres,
    this.locale,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        state,
        configuration,
        genres,
        locale,
        errorMsg,
      ];

  GlobalState copyWith({
    ProcessStatus? state,
    Configuration? configuration,
    List<Genres>? genres,
    Locale? locale,
    String? errorMsg,
  }) {
    return GlobalState(
      state: state ?? this.state,
      configuration: configuration ?? this.configuration,
      genres: genres ?? this.genres,
      locale: locale ?? this.locale,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
