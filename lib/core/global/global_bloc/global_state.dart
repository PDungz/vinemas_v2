// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_bloc.dart';

class GlobalState extends Equatable {
  final StatusState state;
  final Configuration? configuration;
  final Locale? locale;
  final String? errorMsg;

  const GlobalState({
    this.state = StatusState.idle,
    this.configuration,
    this.locale,
    this.errorMsg,
  });

  @override
  List<Object?> get props => [
        state,
        configuration,
        locale,
        errorMsg,
      ];

  GlobalState copyWith({
    StatusState? state,
    Configuration? configuration,
    Locale? locale,
    String? errorMsg,
  }) {
    return GlobalState(
      state: state ?? this.state,
      configuration: configuration ?? this.configuration,
      locale: locale ?? this.locale,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
