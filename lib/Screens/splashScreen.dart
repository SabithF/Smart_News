import 'dart:async';
import 'package:smart_news/consts/colorConst.dart';
import 'package:smart_news/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      //navigate to home screen replacing the view
      Get.offAndToNamed('/homePage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.burgundy,
      body: Center(child: Image.asset('assets/flashNews.jpg')),
    );
  }
}
