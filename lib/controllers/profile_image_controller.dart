import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageController extends GetxController {
  final Rx<File?> _image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();
  final Box _box = Hive.box('profileBox');

  File? get image => _image.value;

  @override
  void onInit() {
    super.onInit();
    _loadSavedImage();
  }

  void _loadSavedImage() {
    final path = _box.get('profileImage');
    if (path != null && File(path).existsSync()) {
      _image.value = File(path);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        _image.value = file;
        _box.put('profileImage', pickedFile.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }
}
