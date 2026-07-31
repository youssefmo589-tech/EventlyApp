import 'package:eventlyapp/core/AppRoutes/AppRouteName.dart';
import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/gen/assets.gen.dart';
import '../../core/themes/AppColors.dart';
import '../../core/utilities/Widgets/AppButton.dart';

class letsStart extends StatefulWidget {
  const letsStart({super.key});

  State<letsStart> createState() {
    return _letsStartState();
  }
}

class _letsStartState extends State<letsStart> {
  bool isenglish = true;

  bool isarabic = false;

  bool issun = false;

  bool ismoon = false;

  Widget build(BuildContext context) {
    final provider = Provider.of<settingProvider>(context);

    final theme = Theme.of(context).textTheme;
    final themeprimarycolor = Theme.of(context).primaryColor;
    final themesecondarycolor = Theme.of(context).secondaryHeaderColor;
    final headlinecolor = Theme.of(context).canvasColor;
    final unselectioncontainer = Theme.of(context).shadowColor;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: 142,
            height: 27,
            child: Assets.images.evently.image(color: themeprimarycolor),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18),
            Assets.images.beingCreative.image(
              color: provider.isDark()
                  ? AppColors.white
                  : AppColors.primaryLight,
            ),
            SizedBox(height: 24),
            Text(
              "Personalize Your Experience",
              style: theme.titleLarge?.copyWith(color: headlinecolor),
            ),
            SizedBox(height: 8),
            Text(
              "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
              style: theme.titleSmall?.copyWith(color: themesecondarycolor),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Language",
                  style: theme.titleMedium?.copyWith(
                    color: provider.isDark()
                        ? AppColors.white
                        : AppColors.primaryLight,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isenglish = true;
                      isarabic = false;
                    });
                  },
                  child: Container(
                    height: 32,
                    width: 83,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.isDark() == true
                            ? AppColors.primaryDark
                            : AppColors.lightgray,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isenglish == true
                          ? themeprimarycolor
                          : unselectioncontainer,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "English",
                        style: isenglish == true
                            ? theme.titleLarge?.copyWith(
                                color: provider.isDark() == false
                                    ? AppColors.white
                                    : AppColors.white,
                                fontSize: 14,
                              )
                            : theme.titleSmall?.copyWith(
                                color: provider.isDark() == false
                                    ? AppColors.primaryLight
                                    : AppColors.white,
                                fontSize: 14,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isarabic = true;
                      isenglish = false;
                    });
                  },
                  child: Container(
                    height: 32,
                    width: 83,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.isDark() == true
                            ? AppColors.primaryDark
                            : AppColors.lightgray,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isarabic == true
                          ? themeprimarycolor
                          : unselectioncontainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.5,
                        horizontal: 15,
                      ),
                      child: Center(
                        child: Text(
                          "Arabic",
                          style: isarabic == true
                              ? theme.titleLarge?.copyWith(
                                  color: provider.isDark() == false
                                      ? AppColors.white
                                      : AppColors.white,
                                  fontSize: 14,
                                )
                              : theme.titleSmall?.copyWith(
                                  color: provider.isDark() == false
                                      ? AppColors.primaryLight
                                      : AppColors.white,
                                  fontSize: 14,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Theme",
                  style: theme.titleMedium?.copyWith(
                    color: provider.isDark()
                        ? AppColors.white
                        : AppColors.primaryLight,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      issun = true;
                      ismoon = false;
                    });

                    provider.changeThemeMode(ThemeMode.light);
                  },
                  child: Container(
                    height: 32,
                    width: 56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.isDark() == true
                            ? AppColors.primaryDark
                            : AppColors.lightgray,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: issun == true
                          ? themeprimarycolor
                          : unselectioncontainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      child: Assets.icons.sun.svg(
                        colorFilter: ColorFilter.mode(
                          provider.isDark() == false
                              ? issun == false
                                    ? AppColors.primaryLight
                                    : AppColors.white
                              : AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      ismoon = true;
                      issun = false;
                    });

                    provider.changeThemeMode(ThemeMode.dark);
                  },
                  child: Container(
                    height: 32,
                    width: 56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: provider.isDark() == true
                            ? AppColors.primaryDark
                            : AppColors.lightgray,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: ismoon == true
                          ? themeprimarycolor
                          : unselectioncontainer,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      child: Assets.icons.moon.svg(
                        colorFilter: ColorFilter.mode(
                          ismoon == true ? AppColors.white : themeprimarycolor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            AppButton(
              text: "Let’s start",
              ontap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouteName.onBoarding,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
