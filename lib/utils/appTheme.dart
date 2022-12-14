import 'package:smart_news/consts/colorConst.dart';
import 'package:flutter/material.dart';

class Themes {
  static final appTheme = ThemeData(
    primaryColor: ColorConst.burgundy,
    scaffoldBackgroundColor: ColorConst.lightGrey,
    buttonTheme: const ButtonThemeData(buttonColor: ColorConst.orangeWeb),
    appBarTheme: const AppBarTheme(backgroundColor: ColorConst.burgundy),
    colorScheme:
    ColorScheme.fromSwatch().copyWith(secondary: ColorConst.orangeWeb),
  );
}
