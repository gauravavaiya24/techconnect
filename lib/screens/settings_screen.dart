import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/controllers/theme_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final ThemeController _themeController = Get.find();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
              value: _themeController.isDarkMode.value,
              onChanged: (value) => _themeController.toggleTheme(),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Show privacy policy
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            onTap: () {
              // Show terms of service
            },
          ),
          const Divider(),
          ListTile(title: const Text('Logout'), onTap: _authController.logout),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'TechConnect v1.0.0',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
