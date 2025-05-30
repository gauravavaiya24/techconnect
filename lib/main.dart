import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/controllers/event_controller.dart';
import 'package:techconnect/routes/app_pages.dart';
import 'package:techconnect/utils/app_theme.dart';

import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('profileBox');
  await GetStorage.init();
  Get.put(ThemeController());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return GetMaterialApp(
      title: 'TechConnect',

      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(EventController()); // Add this line to register EventController
      }),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
