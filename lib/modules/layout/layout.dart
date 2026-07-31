import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:eventlyapp/modules/Home/Home.dart';
import 'package:eventlyapp/modules/favourite/Favourite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/AppRoutes/AppRouteName.dart';
import '../../core/gen/assets.gen.dart';
import '../../core/themes/AppColors.dart';
import '../profile/Profile.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  State<Layout> createState() {
    return _LayoutState();
  }
}

class _LayoutState extends State<Layout> {
  int currentindex = 0;

  List<Widget> pages = [Home(), Favourite(), Profile()];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<settingProvider>(context);

    return Scaffold(
      body: pages[currentindex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: provider.isDark()
            ? AppColors.primaryDark
            : AppColors.primaryLight,
        unselectedItemColor: provider.isDark()
            ? AppColors.lightgray
            : AppColors.darkgrey,
        currentIndex: currentindex,
        backgroundColor: provider.isDark()
            ? AppColors.backgrounddark
            : AppColors.backgroundlight,
        selectedLabelStyle: TextStyle(
          color: provider.isDark()
              ? AppColors.primaryDark
              : AppColors.primaryLight,
        ),
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home2.image(
              color: provider.isDark()
                  ? AppColors.darkgrey
                  : AppColors.lightgray,
              width: 24,
              height: 24,
            ),
            label: "Home",

            activeIcon: Assets.icons.home2.image(
              color: provider.isDark()
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.vector.image(
              color: provider.isDark()
                  ? AppColors.darkgrey
                  : AppColors.lightgray,
              width: 24,
              height: 24,
            ),
            label: "Favourite",
            activeIcon: Assets.icons.vector.image(
              color: provider.isDark()
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.userPng.image(
              color: provider.isDark()
                  ? AppColors.darkgrey
                  : AppColors.lightgray,
              width: 24,
              height: 24,
            ),
            label: "Profile",
            activeIcon: Assets.icons.userPng.image(
              color: provider.isDark()
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),

      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouteName.AddEvent);
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: provider.isDark()
                ? AppColors.primaryDark
                : AppColors.primaryLight,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.3),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
