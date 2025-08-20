import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTheme {
  static const Color mainColor = Color(0xff326db1);
  static const Color subColor = Color.fromARGB(255, 35, 162, 247);
  static const Color sub2Color = Color.fromARGB(255, 82, 186, 255);

  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      leadingWidth: 28.w,
      toolbarHeight: 41.h,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
  );
}