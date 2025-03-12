// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/ticket/data/data_source/ticket_remote_data_source.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';
import 'package:vinemas_v1/features/ticket/domain/repository/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource ticketRemoteDataSource;

  TicketRepositoryImpl({
    required this.ticketRemoteDataSource,
  });

  @override
  Future<void> bookTicket(
      {required Ticket ticket,
      required Function(
              {required String message, required ProcessStatus status})
          onPressed}) async {
    await ticketRemoteDataSource.bookTicket(
        ticket: ticket, onPressed: onPressed);
  }

  @override
  Future<List<Ticket>?> getTickets() async {
    return ticketRemoteDataSource.getTickets();
  }
}
