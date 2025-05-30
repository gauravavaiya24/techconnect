import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/controllers/event_controller.dart';
import 'package:techconnect/controllers/theme_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => EventController(), fenix: true);
    Get.put(ThemeController());
  }
}
