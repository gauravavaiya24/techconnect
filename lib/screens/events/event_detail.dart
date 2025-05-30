// event_detail.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/controllers/event_controller.dart';
import 'package:techconnect/models/comment.dart';
import 'package:intl/intl.dart';
import 'package:techconnect/models/user.dart';
import '../../models/event.dart';

class EventDetailScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final EventController controller = Get.find();
  final TextEditingController commentCtrl = TextEditingController();

  EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Event event = Get.arguments;

    // var data = authController.currentUserId;

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventInfo(event),
            const SizedBox(height: 12),
            _buildCommentInput(event.id),
            const SizedBox(height: 12),
            Expanded(child: _buildCommentList(event.id)),
          ],
        ),
      ),
    );
  }

  Widget _buildEventInfo(Event event) {
    String dateString = event.date;

    // Remove the timezone part to simplify parsing
    String cleanedDate = dateString.replaceAll(" UTC+10", "");

    // Define the format
    DateFormat format = DateFormat("MMMM d, yyyy 'at' hh:mm:ss a");

    // Parse to DateTime
    DateTime dateTime = format.parse(cleanedDate);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,

        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(event.imageUrl),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          Text(event.description, style: Get.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text("📍 ${event.location}", style: Get.textTheme.bodyMedium),
          Text(
            "📅 ${DateFormat('MMM d, y – h:mm a').format(dateTime)}",
            style: Get.textTheme.bodyMedium,
          ),
          Text("👥 ${event.attendees.length}/${event.capacity} attending"),
        ],
      ),
    );
  }

  Widget _buildCommentInput(String eventId) {
    AppUser? currentUser = authController.currentUser.value;
    // print('user print ${currentUser?.email}');

    return TextField(
      controller: commentCtrl,
      decoration: InputDecoration(
        hintText: 'Write a comment...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            final text = commentCtrl.text.trim();
            if (text.isNotEmpty) {
              controller.addComment(
                eventId: eventId,
                text: text,
                userName: currentUser?.name ?? 'Unknown',
              );
              commentCtrl.clear();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCommentList(String eventId) {
    return StreamBuilder<List<Comment>>(
      stream: controller.getCommentsStream(eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Error loading comments: ${snapshot.error}"),
          );
        }

        final comments = snapshot.data;

        if (comments == null) {
          return const Center(child: Text("Loading comments..."));
        }

        if (comments.isEmpty) {
          return const Center(child: Text("No comments yet."));
        }

        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (_, index) {
            final c = comments[index];
            return ListTile(
              title: Text(c.userName),
              subtitle: Text(c.text),
              trailing: Text(DateFormat.Hm().format(c.timestamp)),
            );
          },
        );
      },
    );
  }
}
