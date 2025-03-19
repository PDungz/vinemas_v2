// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pay_bloc.dart';

abstract class PayState extends Equatable {}

class PayInitial extends PayState {
  @override
  List<Object?> get props => [];
}

class PaymentTicketState extends PayState {
  final ProcessStatus processStatus;
  final Ticket? ticket;
  final String? message;

  PaymentTicketState({
    this.processStatus = ProcessStatus.idle,
    this.ticket,
    this.message,
  });

  @override
  List<Object?> get props => [processStatus, message];



  PaymentTicketState copyWith({
    ProcessStatus? processStatus,
    Ticket? ticket,
    String? message,
  }) {
    return PaymentTicketState(
      processStatus: processStatus ?? this.processStatus,
      ticket: ticket ?? this.ticket,
      message: message ?? this.message,
    );
  }
}
