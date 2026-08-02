import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';
import '../../provider/settingsProvider.dart';
import '../../themes/AppColors.dart';

class SelectionDateTime extends StatelessWidget {
  final DateTime? selecteddatetime;
  final TimeOfDay ? selectedtime;

  final void Function(BuildContext context)? timebehav;
  final void Function()? onTap;

  const SelectionDateTime({
    super.key,
    required this.onTap,
    required this.selecteddatetime,
    this.selectedtime,
    this.timebehav,
  });

  Widget build(BuildContext context) {
    final provider = Provider.of<settingProvider>(context);
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  Assets.icons.calendarAdd.svg(
                    colorFilter: ColorFilter.mode(
                      provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    "Event Date",
                    style: theme.titleMedium?.copyWith(
                      color: provider.isDark() ? AppColors.white : AppColors
                          .black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,

                child: Text(
                  selecteddatetime != null
                      ? DateFormat("dd , MMM yyyy").format(selecteddatetime!)
                      : "Choose date",
                  style: theme.titleSmall?.copyWith(
                    color: provider.isDark()
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: provider.isDark()
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,
                    decorationThickness: 1.5,
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  Icon(Icons.access_time,
                    color: provider.isDark() ? AppColors.primaryDark : AppColors
                        .primaryLight,),
                  Text(
                    "Event Time",
                    style: theme.titleMedium?.copyWith(
                      color: provider.isDark() ? AppColors.white : AppColors
                          .black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  timebehav!(context);
                },
                child: selectedtime == null ? Text(
                    "Choose Time",
                    style: theme.titleSmall?.copyWith(
                      color: provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      decorationThickness: 1.5,

                    )) : Text(
                    selectedtime!.format(context),
                    style: theme.titleSmall?.copyWith(
                      color: provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      decorationThickness: 1.5,

                    )


                ),
              )
            ],
          ),
        ],
      ),
    );
  }


}
