import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techconnect/models/comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            // backgroundImage:
            //     comment.userPhotoUrl != null
            //         ? NetworkImage(comment.userPhotoUrl!)
            //         : const AssetImage('assets/default_avatar.png')
            //             as ImageProvider,
            
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(comment.text),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM d, y - h:mm a').format(comment.timestamp),
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
