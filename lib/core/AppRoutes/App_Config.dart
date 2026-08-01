import 'package:eventlyapp/core/AppRoutes/AppRouteName.dart';
import 'package:eventlyapp/modules/AddEvent/AddEvent.dart';
import 'package:eventlyapp/modules/Authentication/Login/ForgetPassword/ForgetPassword.dart';
import 'package:eventlyapp/modules/Authentication/Login/LoginPage.dart';
import 'package:eventlyapp/modules/Authentication/SignUp/SignUp.dart';
import 'package:eventlyapp/modules/layout/layout.dart';
import 'package:eventlyapp/modules/letsStart/letsStart.dart';
import 'package:eventlyapp/modules/onBoarding/onBoardingPage.dart';
import 'package:eventlyapp/modules/splash/SplashScreen.dart';
import 'package:flutter/material.dart';

import '../../modules/AddEvent/EventDetails.dart';

abstract class AppConfig {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.initial:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case AppRouteName.letsstart:
        return MaterialPageRoute(builder: (context) => letsStart());

      case AppRouteName.onBoarding:
        return MaterialPageRoute(builder: (context) => onBoarding());

      case AppRouteName.Login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case AppRouteName.SignUP:
        return MaterialPageRoute(builder: (context) => SignUp());

      case AppRouteName.ForgetPassword:
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case AppRouteName.Layout:
        return MaterialPageRoute(builder: (context) => Layout());
      case AppRouteName.AddEvent:
        return MaterialPageRoute(builder: (context) => AddEvent());
      case AppRouteName.EventDetails:
        return MaterialPageRoute(builder: (context) => EventDetails());

      default:
        return null;
    }
  }
}
