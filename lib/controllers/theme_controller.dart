// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ThemeController extends GetxController {
//   final RxBool isDarkMode = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize from system preferences or saved preference
//     isDarkMode.value = Get.isDarkMode;
//   }
//
//   void toggleTheme() {
//     isDarkMode.toggle();
//     Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
//     // Save preference to local storage if needed
//   }
// }
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'isDarkMode';
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _loadThemeFromStorage();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  bool _loadThemeFromStorage() => _storage.read(_key) ?? Get.isDarkMode;

  void _saveThemeToStorage(bool value) => _storage.write(_key, value);

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToStorage(isDarkMode.value);
  }
}
