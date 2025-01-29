part of 'global_bloc.dart';

class GlobalInitEvent extends GlobalEvent {}

abstract class GlobalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetSharedPreferenceEvent extends GlobalEvent {
  final String key;
  final dynamic value;

  SetSharedPreferenceEvent({required this.key, required this.value});

  @override
  List<Object?> get props => [key, value];
}

class GetSharedPreferenceEvent extends GlobalEvent {
  final String key;

  GetSharedPreferenceEvent({required this.key});

  @override
  List<Object?> get props => [key];
}
