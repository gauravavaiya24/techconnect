import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_image_controller.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({super.key});

  final ProfileImageController controller = Get.put(ProfileImageController());

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a Picture'),
            onTap: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Obx(() {
          final imageFile = controller.image;
          return Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: imageFile != null
                  ? Colors.transparent : Colors.black12,
              borderRadius: BorderRadius.circular(50),
            ),
            child: imageFile != null
                ? ClipOval(
              child: Image.file(
                imageFile,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            )
                : Icon(Icons.person, size: 70),
          );
        }),
        Positioned(
          left: 70,
          top: 65,
          child: GestureDetector(
            onTap: () => _showImageSourceDialog(context),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.image, size: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
