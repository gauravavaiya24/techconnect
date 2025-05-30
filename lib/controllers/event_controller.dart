import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:techconnect/models/comment.dart';
import 'package:techconnect/models/event.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Event> events = <Event>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool isLoading = false.obs;

  final List<String> categories = [
    'All',
    'Workshop',
    'Conference',
    'Meetup',
    'Hackathon',
  ];

  RxList<Event> get filteredEvents {
    if (selectedCategory.value == 'All') return events;
    return events
        .where((e) => e.category == selectedCategory.value)
        .toList()
        .obs;
  }

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() {
    isLoading.value = true;
    _firestore.collection('events').snapshots().listen((snapshot) {
      events.assignAll(
        snapshot.docs.map((doc) => Event.fromJson(doc.data())).toList(),
      );
      isLoading.value = false;
    });
  }

  void addComment({required String eventId, required String text, required String userName}) {
    _firestore.collection('comments').add({
      'eventId': eventId,
      'userId': 'testUserId',
      'userName': userName,
      'text': text,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<List<Comment>> getCommentsStream(String eventId) {
    return _firestore
        .collection('comments')
        .where('eventId', isEqualTo: eventId)
        .orderBy('timestamp') // ascending (no index needed)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => Comment.fromMap(doc.data(), doc.id))
                  .toList(),
        );
  }
}
