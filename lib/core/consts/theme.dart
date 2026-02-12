import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

ThemeData buildDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colours.primary,

    /// AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colours.primary,
      elevation: 0,
      centerTitle: true,
    ),

    /// Font Family Global
    fontFamily: Fonts.medium,

    /// Divider
    dividerColor: Colours.divider,

    /// Buttons Theme (IMPORTANT PART)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.white,
        foregroundColor: Colours.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // Sharper corners
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        textStyle: TextStyle(
          fontFamily: Fonts.semiBold,
          fontSize: 16.sp,
          letterSpacing: 1.2,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colours.white,
        side: const BorderSide(color: Colours.white, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        textStyle: TextStyle(
          fontFamily: Fonts.medium,
          fontSize: 15.sp,
          letterSpacing: 1.1,
        ),
      ),
    ),
  );
}
