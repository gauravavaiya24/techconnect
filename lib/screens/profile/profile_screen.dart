import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/controllers/theme_controller.dart';
import 'package:techconnect/models/user.dart';
import 'package:techconnect/routes/app_pages.dart';
import 'package:techconnect/utils/app_colors.dart';
import 'package:techconnect/widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = Get.find();
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), elevation: 0),
      body: Obx(() {
        final user = _authController.currentUser.value;
        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 64,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(height: 16),
                Text(
                  'Please sign in',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserProfile(user),
              const SizedBox(height: 24),
              // _buildStatsSection(user),
              const SizedBox(height: 32),
              _buildActionsSection(),
              const SizedBox(height: 32),
              _buildSettingsSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUserProfile(AppUser user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              ProfileImage(),
              const SizedBox(height: 20),
              Text(
                user.name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              if (user.location.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      user.location,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildStatsSection(AppUser user) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           _buildStatItem('Events Attending', user.attendingEvents.length),
  //           Container(
  //             height: 40,
  //             width: 1,
  //             color: Theme.of(context).dividerTheme.color,
  //           ),
  //           _buildStatItem('Events Hosting', user.hostingEvents.length),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildStatItem(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.EDIT_PROFILE),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Obx(
                () => SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: Text(
                    _themeController.isDarkMode.value
                        ? 'Dark theme enabled'
                        : 'Light theme enabled',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: _themeController.isDarkMode.value,
                  onChanged: (value) => _themeController.toggleTheme(),
                  secondary: Icon(
                    _themeController.isDarkMode.value
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Support',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.snackbar(
                    'Privacy Policy',
                    'Coming soon...',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('Terms of Service'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.snackbar(
                    'Terms of Service',
                    'Coming soon...',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.red,
                ),
                onTap: () => _showLogoutDialog(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            'TechConnect v1.0.0',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _authController.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
