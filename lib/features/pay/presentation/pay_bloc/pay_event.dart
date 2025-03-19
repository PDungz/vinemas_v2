// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pay_bloc.dart';

abstract class PayEvent extends Equatable {}

class PaymentTicketEvent extends PayEvent {
  final int amount;
  final String currency;
  final PayMethodEnum payMethodEnum;
  final TicketModel ticketModel;
  final SessionMovie sessionMovie;
  PaymentTicketEvent({
    required this.amount,
    required this.currency,
    required this.payMethodEnum,
    required this.ticketModel,
    required this.sessionMovie,
  });

  @override
  List<Object?> get props =>
      [amount, currency, payMethodEnum, ticketModel, sessionMovie];

  PaymentTicketEvent copyWith({
    int? amount,
    String? currency,
    PayMethodEnum? payMethodEnum,
    TicketModel? ticketModel,
    SessionMovie? sessionMovie,
  }) {
    return PaymentTicketEvent(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      payMethodEnum: payMethodEnum ?? this.payMethodEnum,
      ticketModel: ticketModel ?? this.ticketModel,
      sessionMovie: sessionMovie ?? this.sessionMovie,
    );
  }
}

class RefundTicketEvent extends PayEvent {
  final int amount;
  final String currency;
  final PayMethodEnum payMethodEnum;
  final TicketModel ticketModel;
  final SessionMovie sessionMovie;
  RefundTicketEvent({
    required this.amount,
    required this.currency,
    required this.payMethodEnum,
    required this.ticketModel,
    required this.sessionMovie,
  });

  @override
  List<Object?> get props =>
      [amount, currency, payMethodEnum, ticketModel, sessionMovie];

  RefundTicketEvent copyWith({
    int? amount,
    String? currency,
    PayMethodEnum? payMethodEnum,
    TicketModel? ticketModel,
    SessionMovie? sessionMovie,
  }) {
    return RefundTicketEvent(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      payMethodEnum: payMethodEnum ?? this.payMethodEnum,
      ticketModel: ticketModel ?? this.ticketModel,
      sessionMovie: sessionMovie ?? this.sessionMovie,
    );
  }
}
