// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Wait for auth state to be initialized
      await _authController.checkInitialAuthState();

      Get.offNamed(
        _authController.currentUser.value != null
            ? AppRoutes.EVENTS
            : AppRoutes.LOGIN,
      );
    } catch (e) {
      Get.offNamed(AppRoutes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/pngs/wirelessNetworkConnectivityDevice.png',width: 300,),
            const SizedBox(height: 20),
            const Text(
              'TechConnect',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
