import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String eventId;
  final String userId;
  final String text;
  final DateTime timestamp;
  final String userName;

  Comment({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.text,
    required this.timestamp,
    required this.userName,
  });

  factory Comment.fromMap(Map<String, dynamic> data, String id) {
    return Comment(
      id: id,
      eventId: data['eventId'] ?? '',
      userId: data['userId'] ?? '',
      text: data['text'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      userName: data['userName'] ?? '',
    );
  }
}
