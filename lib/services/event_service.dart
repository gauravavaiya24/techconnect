import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techconnect/models/event.dart';
import 'package:techconnect/models/comment.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Event>> getEventsStream() {
    return _firestore
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: DateTime.now())
        .orderBy('date')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList(),
        );
  }

  Future<Event> getEventById(String eventId) async {
    final doc = await _firestore.collection('events').doc(eventId).get();
    if (!doc.exists) throw 'Event not found';
    return Event.fromJson(doc.data()!);
  }

  Stream<List<Comment>> getCommentsStream(String eventId) {
    return _firestore
        .collection('comments')
        .where('eventId', isEqualTo: eventId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => Comment.fromMap(doc.data(), doc.id))
                  .toList(),
        );
  }

  Future<void> addComment(
    String eventId,
    String text,
    String userId,
    String userName,
    String? userPhotoUrl,
  ) async {
    await _firestore.collection('comments').add({
      'eventId': eventId,
      'userId': userId,
      'text': text,
      'timestamp': DateTime.now(),
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
    });
  }

  Future<void> toggleAttendance(
    String eventId,
    String userId,
    bool isAttending,
  ) async {
    final batch = _firestore.batch();
    final eventRef = _firestore.collection('events').doc(eventId);
    final userRef = _firestore.collection('users').doc(userId);

    batch.update(eventRef, {
      'attendees':
          isAttending
              ? FieldValue.arrayRemove([userId])
              : FieldValue.arrayUnion([userId]),
    });

    batch.update(userRef, {
      'attendingEvents':
          isAttending
              ? FieldValue.arrayRemove([eventId])
              : FieldValue.arrayUnion([eventId]),
    });

    await batch.commit();
  }
}
