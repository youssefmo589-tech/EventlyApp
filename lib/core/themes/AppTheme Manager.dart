import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AppColors.dart';

abstract class AppThemeManager {
  static ThemeData getlighttheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    secondaryHeaderColor: AppColors.darkgrey,

    shadowColor: AppColors.white,

    canvasColor: AppColors.black,

    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: AppColors.backgroundlight,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData getdarktheme = ThemeData(
    shadowColor: AppColors.darkblue,
    canvasColor: AppColors.white,

    secondaryHeaderColor: AppColors.lightgray,
    primaryColor: AppColors.primaryDark,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,

        backgroundColor: Colors.transparent),
    scaffoldBackgroundColor: AppColors.backgrounddark,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
