import 'package:flutter/material.dart';
import 'utils/appRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/appTheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News API',

        theme: Themes.appTheme,
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.routes,
    );
  }
}

