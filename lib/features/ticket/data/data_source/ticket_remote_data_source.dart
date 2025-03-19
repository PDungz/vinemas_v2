import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/features/ticket/data/model/ticket_model.dart';
import 'package:vinemas_v1/features/ticket/domain/entity/ticket.dart';

abstract class TicketRemoteDataSource {
  Future<TicketModel?> bookTicket({
    required Ticket ticket,
    required Function({required String message, required ProcessStatus status})
        onPressed,
  });

  Future<List<TicketModel>?> getTickets();

  Future<void> updateBookTicket({required Ticket ticket});
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<TicketModel?> bookTicket({
    required Ticket ticket,
    required Function({
      required String message,
      required ProcessStatus status,
    }) onPressed,
  }) async {
    try {
      DocumentReference docRef = await _firestore
          .collection('ticket')
          .add(TicketModel.fromEntity(ticket).toJson());

      // Lấy lại dữ liệu từ Firestore để đảm bảo ticketId được cập nhật đúng
      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        data['ticketId'] = docRef.id; // Gán ticketId từ Firestore
        TicketModel bookedTicket = TicketModel.fromJson(data);

        onPressed(
            message: "Ticket booked successfully",
            status: ProcessStatus.success);
        return bookedTicket;
      }
    } catch (e) {
      onPressed(
          message: "Failed to book ticket: ${e.toString()}",
          status: ProcessStatus.failure);
    }
    return null;
  }

  @override
  Future<List<TicketModel>?> getTickets() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('ticket').get();
      List<TicketModel> tickets = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['ticketId'] = doc.id;
        return TicketModel.fromJson(data);
      }).toList();
      return tickets;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateBookTicket({
    required Ticket ticket,
  }) async {
    try {
      if (ticket.ticketId.isNotEmpty) {
        await _firestore
            .collection('ticket')
            .doc(ticket.ticketId)
            .update(TicketModel.fromEntity(ticket).toJson());
      } else {
        throw Exception("Invalid ticket ID");
      }
    } catch (e) {
      throw Exception("Failed to update ticket: ${e.toString()}");
    }
  }
}
