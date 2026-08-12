import 'package:eventlyapp/core/AppRoutes/AppRouteName.dart';
import 'package:flutter/material.dart';

import '../../core/gen/assets.gen.dart';
import '../../core/themes/AppColors.dart';
import '../../core/utilities/checkonboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    checkonboarding();
  }

  void dispose() {
    super.dispose();
  }

  void checkonboarding() async
  {
    bool seen = await CheckOnBoarding.getSeen();
    if (seen) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouteName.Login, (route) => false);
      });
    }
    else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouteName.letsstart, (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Assets.images.evently.image(color: AppColors.primaryLight),
        ),
      ),
    );
  }
}
