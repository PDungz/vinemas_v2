import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';

abstract class TicketRemoteDataSource {
  Future<void> bookTicket({
    required Ticket ticket,
    required Function({required String message, required ProcessStatus status})
        onPressed,
  });

  Future<List<TicketModel>?> getTickets();
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> bookTicket({
    required Ticket ticket,
    required Function({required String message, required ProcessStatus status})
        onPressed,
  }) async {
    try {
      await _firestore
          .collection('ticket')
          .add(TicketModel.fromEntity(ticket).toJson());
      onPressed(
          message: "Ticket booked successfully", status: ProcessStatus.success);
    } catch (e) {
      onPressed(
          message: "Failed to book ticket: ${e.toString()}",
          status: ProcessStatus.failure);
    }
  }

  @override
  Future<List<TicketModel>?> getTickets() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('ticket').get();
      List<TicketModel> tickets = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['ticketId'] = doc.id;
        return TicketModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return tickets;
    } catch (e) {
      return null;
    }
  }
}
