import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/theme_controller.dart';

class ThemeSwitchWidget extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.light_mode,
            size: 20,
            color: _themeController.isDarkMode.value
                ? Colors.grey
                : Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Switch(
            value: _themeController.isDarkMode.value,
            onChanged: (value) => _themeController.toggleTheme(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.dark_mode,
            size: 20,
            color: _themeController.isDarkMode.value
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
        ],
      ),
    ));
  }
}