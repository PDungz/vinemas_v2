// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pay_bloc.dart';

abstract class PayEvent extends Equatable {}

class PaymentTicketEvent extends PayEvent {
  final int amount;
  final String currency;
  final PayMethodEnum payMethodEnum;
  final TicketModel ticketModel;
  final SessionMovie sessionMovie;
  final String? content;
  PaymentTicketEvent({
    required this.amount,
    required this.currency,
    required this.payMethodEnum,
    required this.ticketModel,
    required this.sessionMovie,
    this.content,
  });

  @override
  List<Object?> get props =>
      [amount, currency, payMethodEnum, ticketModel, sessionMovie, content];

  PaymentTicketEvent copyWith({
    int? amount,
    String? currency,
    PayMethodEnum? payMethodEnum,
    TicketModel? ticketModel,
    SessionMovie? sessionMovie,
    String? content,
  }) {
    return PaymentTicketEvent(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      payMethodEnum: payMethodEnum ?? this.payMethodEnum,
      ticketModel: ticketModel ?? this.ticketModel,
      sessionMovie: sessionMovie ?? this.sessionMovie,
      content: content ?? this.content,
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

class PaymentTicketChangeShowTimeEvent extends PayEvent {
  final int amount;
  final String currency;
  final PayMethodEnum payMethodEnum;
  final TicketModel ticketModel;
  final SessionMovie sessionMovie;
  final List<String> seats;
  final String? content;
  PaymentTicketChangeShowTimeEvent({
    required this.amount,
    required this.currency,
    required this.payMethodEnum,
    required this.ticketModel,
    required this.sessionMovie,
    required this.seats,
    this.content,
  });

  @override
  List<Object?> get props =>
      [amount, currency, payMethodEnum, ticketModel, sessionMovie, content];

  PaymentTicketChangeShowTimeEvent copyWith({
    int? amount,
    String? currency,
    PayMethodEnum? payMethodEnum,
    TicketModel? ticketModel,
    SessionMovie? sessionMovie,
    List<String>? seats,
    String? content,
  }) {
    return PaymentTicketChangeShowTimeEvent(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      payMethodEnum: payMethodEnum ?? this.payMethodEnum,
      ticketModel: ticketModel ?? this.ticketModel,
      sessionMovie: sessionMovie ?? this.sessionMovie,
      seats: seats ?? this.seats,
      content: content ?? this.content,
    );
  }
}
