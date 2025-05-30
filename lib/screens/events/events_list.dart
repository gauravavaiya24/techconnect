import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/event_controller.dart';
import 'package:techconnect/screens/events/event_detail.dart';
import '../../controllers/profile_image_controller.dart';
import '../../routes/app_pages.dart';

class EventsListScreen extends StatelessWidget {
  final EventController controller = Get.put(EventController());
  final ProfileImageController profileImageController = Get.put(
    ProfileImageController(),
  );

  EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Events'),
        actions: [
          Obx(() {
            final imageFile = profileImageController.image;
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.PROFILE),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      imageFile != null ? FileImage(imageFile) : null,
                  child:
                      imageFile == null
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
                ),
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children:
                    controller.categories.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: controller.selectedCategory.value == cat,
                          onSelected:
                              (_) => controller.selectedCategory.value = cat,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredEvents.isEmpty) {
                return const Center(child: Text("No events found"));
              }

              return ListView.builder(
                itemCount: controller.filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = controller.filteredEvents[index];

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
                              image: NetworkImage(event.imageUrl),fit: BoxFit.fitWidth
                            ),
                          ),
                        ),
                    
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(event.title),
                          subtitle: Text(event.location),
                          onTap: () {
                            Get.defaultDialog(
                              title: "RSVP?",
                              middleText:
                                  "Would you like to RSVP for this event?",
                              textConfirm: "Yes",
                              textCancel: "No",
                              onConfirm: () {
                                Get.back();
                                Get.to(
                                  () => EventDetailScreen(),
                                  arguments: event,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
