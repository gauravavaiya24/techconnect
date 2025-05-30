import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/widgets/custom_textfield.dart';
import 'package:techconnect/widgets/profile_image.dart';

class EditProfileScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Obx(() {
            final user = authController.currentUser.value;
            if (user != null) {
              _nameController.text = user.name;
              _locationController.text = user.location;
            }

            return Column(
              children: [
                ProfileImage(),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _nameController,
                  label: 'Name',
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                  hintText: 'Please enter your name',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _locationController,
                  label: 'Location',
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Please enter your location' : null,
                  hintText: 'Please enter your location',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        authController.isLoading.value
                            ? null
                            : () => _saveProfile(authController),
                    child:
                        authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Save Changes'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<void> _saveProfile(AuthController authController) async {
    if (!_formKey.currentState!.validate()) return;
    await authController.updateProfile(
      _nameController.text.trim(),
      _locationController.text.trim(),
    );
  }
}
