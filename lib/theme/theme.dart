import 'package:flutter/material.dart';
import 'package:junior_tools/theme/colors.dart';


final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: KConstantColors.whiteColor,
  primaryColor: KConstantColors.appPrimaryColor,
  colorScheme: ColorScheme.light(
    primary: KConstantColors.appPrimaryColor,
    secondary: KConstantColors.secondaryColor,
    background: KConstantColors.whiteColor,
    surface: KConstantColors.greyColor,
    onPrimary: Colors.white,
    onSecondary: KConstantColors.greyColor,
    onBackground: KConstantColors.greyColorBg,
    onSurface: Colors.black,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.black54),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: KConstantColors.bgColor,
  primaryColor: KConstantColors.appPrimaryColor,
  colorScheme: ColorScheme.dark(
    primary: KConstantColors.appPrimaryColor,
    secondary: KConstantColors.secondaryColor,
    background: KConstantColors.bgColor,
    surface: KConstantColors.bgColorFaint,
    onPrimary: Colors.white,
    onSecondary: const Color.fromARGB(255, 41, 41, 41),
    onBackground: KConstantColors.greyColorBg,
    onSurface: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.white70),
  ),
);
