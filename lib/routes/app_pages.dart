// app_pages.dart
import 'package:get/get.dart';
import 'package:techconnect/screens/auth/login_screen.dart';
import 'package:techconnect/screens/auth/signup_screen.dart';
import 'package:techconnect/screens/events/event_detail.dart';
import 'package:techconnect/screens/events/events_list.dart';
import 'package:techconnect/screens/profile/edit_profile.dart';
import 'package:techconnect/screens/profile/profile_screen.dart';
import 'package:techconnect/screens/splash/splash_screen.dart';


abstract class AppRoutes {
  static const SPLASH = '/';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const EVENTS = '/events';
  static const EVENT_DETAIL = '/event-detail'; // Changed from '/event/:id'
  static const PROFILE = '/profile';
  static const EDIT_PROFILE = '/edit-profile';
  static const SEARCH = '/search';
  static const SETTING = '/setting';
}

abstract class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: AppRoutes.EVENTS,
      page: () => EventsListScreen(),
    ),
    GetPage(
      name: AppRoutes.EVENT_DETAIL,
      page: () => EventDetailScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfileScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => EditProfileScreen(),
      transition: Transition.fade,
    ),
  ];
}
