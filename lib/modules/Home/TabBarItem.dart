import 'package:eventlyapp/MODELS/CategoryData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/settingsProvider.dart';
import '../../core/themes/AppColors.dart';

class TabBarItem extends StatelessWidget {
  final bool isselected;

  final CategoryData item;

  const TabBarItem({super.key, required this.item, this.isselected = true});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isselected
            ? provider.isDark()
                  ? AppColors.primaryDark
                  : AppColors.primaryLight
            : provider.isDark()
            ? AppColors.backgrounddark
            : AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 8,
        children: [
          Icon(
            item.icon,
            color: isselected
                ? provider.isDark() == false
                      ? AppColors.white
                      : AppColors.white
                : provider.isDark()
                ? AppColors.primaryDark
                : AppColors.primaryLight,
          ),
          Text(
            item.name,
            style: theme.titleMedium?.copyWith(
              color: isselected
                  ? provider.isDark() == false
                        ? AppColors.white
                        : AppColors.white
                  : provider.isDark()
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
