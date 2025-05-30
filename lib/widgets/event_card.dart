import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({super.key, required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_getCategoryIcon(event.category)),
                  SizedBox(width: 8),
                  Text(event.title, style: Get.textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 8),
              _buildDetailRow(Icons.calendar_today, event.date),
              const SizedBox(height: 4),
              _buildDetailRow(Icons.location_on, event.location),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(label: Text(event.category)),
                  _buildAttendanceCount(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildAttendanceCount() {
    return Row(
      children: [
        const Icon(Icons.people, size: 16),
        const SizedBox(width: 4),
        Text('${event.attendees.length}/${event.capacity}'),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Hackathons':
        return Icons.code;
      case 'Meetups':
        return Icons.people;
      case 'Pitch Events':
        return Icons.mic;
      case 'Workshops':
        return Icons.school;
      default:
        return Icons.event;
    }
  }
}
