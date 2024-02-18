import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_colors.dart';

class AppTheme {
  AppTheme._privateConstructor();
  static final AppTheme _instance = AppTheme._privateConstructor();
  static AppTheme get instance => _instance;

  static ThemeData lightTheme = ThemeData(
    // app bar
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: AppColor.flamingo),
    ),
    // app color
    colorScheme: const ColorScheme.light(
      errorContainer: AppColor.red,
      background: AppColor.text,
      onBackground: AppColor.sapphire,
    ),

    //text
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'concert_one'),
      displaySmall: TextStyle(
          fontSize: 20, color: AppColor.crust, fontFamily: 'concert_one'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle:
          const TextStyle(color: AppColor.crust, fontFamily: 'concert_one'),
      filled: true,
      fillColor: AppColor.teal,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColor.sky,
          foregroundColor: AppColor.crust,
          textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // app bar
    appBarTheme: const AppBarTheme(
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: AppColor.flamingo),
    ),
    // app color
    colorScheme: const ColorScheme.light(
        background: AppColor.crust,
        onBackground: AppColor.mantle,
        errorContainer: AppColor.red),

    //text
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 25,
          color: AppColor.lavender,
          fontWeight: FontWeight.w500,
          fontFamily: 'concert_one'),
      displaySmall: TextStyle(
          fontSize: 20, color: AppColor.lavender, fontFamily: 'concert_one'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle:
          const TextStyle(color: AppColor.lavender, fontFamily: 'concert_one'),
      filled: true,
      fillColor: AppColor.mantle,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColor.blue,
          foregroundColor: AppColor.crust,
          textStyle: const TextStyle(
              fontSize: 18,
              color: AppColor.lavender,
              fontWeight: FontWeight.normal,
              fontFamily: 'concert_one')),
    ),
  );
}
