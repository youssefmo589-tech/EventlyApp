import 'package:eventlyapp/core/utilities/Widgets/AppButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/provider/settingsProvider.dart';
import '../../../../core/themes/AppColors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  State<ForgetPassword> createState() {
    return _ForgetPasswordState();
  }
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  color: provider.isDark()
                      ? AppColors.darkblue
                      : AppColors.lightgray,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark()
                    ? AppColors.backgrounddark
                    : AppColors.white,
              ),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: provider.isDark()
                        ? AppColors.white
                        : AppColors.primaryLight,
                  ),
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 80,

        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Forget Password", style: theme.titleMedium),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 34.5),
            Assets.images.changeSetting.image(
              color: provider.isDark()
                  ? AppColors.white
                  : AppColors.primaryLight,
            ),
            SizedBox(height: 40),
            AppButton(text: "Reset Password", ontap: () {}),
          ],
        ),
      ),
    );
  }
}
