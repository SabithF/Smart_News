import 'package:smart_news/Screens/home.dart';
import 'package:smart_news/Screens/splashScreen.dart';
import 'package:smart_news/Screens/webView.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';


class AppRoutes {
  AppRoutes._();
  static const initial = '/splashScreen';
  static final routes = [
    GetPage(
        name: '/splashScreen',
        page: () => const SplashScreen(),
        transition: Transition.zoom),
    GetPage(
        name: '/homePage',
        page: () => HomePage(),
        transition: Transition.fadeIn),
  ];
}
