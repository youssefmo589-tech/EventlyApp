import 'package:eventlyapp/category%20data%20source/CategoryDataSource.dart';
import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:eventlyapp/core/utiles/firebasecloudservice.dart';
import 'package:eventlyapp/modules/AddEvent/EventData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/gen/assets.gen.dart';
import '../../core/themes/AppColors.dart';

class EventCardItem extends StatefulWidget {
  final EventData event;

  const EventCardItem({super.key, required this.event});

  State<EventCardItem> createState() {
    return _EventCardItemState();
  }
}

class _EventCardItemState extends State<EventCardItem> {
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 193,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: provider.isDark()
                ? AssetImage(
                    CategoryDataSource.getcategorybuid(
                      widget.event.categoryId,
                    ).darkimage,
                  )
                : AssetImage(
                    CategoryDataSource.getcategorybuid(
                      widget.event.categoryId,
                    ).image,
                  ),
            fit: BoxFit.cover,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: provider.isDark() ? AppColors.darkblue : AppColors.lightgray,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 66,
                height: 40,
                decoration: BoxDecoration(
                  color: provider.isDark()
                      ? AppColors.backgrounddark
                      : AppColors.backgroundlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: provider.isDark()
                        ? AppColors.darkblue
                        : AppColors.lightgray,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat(
                        "dd,MMM",
                      ).format(widget.event.selecteddatetime!),
                      style: theme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: provider.isDark()
                            ? AppColors.primaryDark
                            : AppColors.primaryLight,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: provider.isDark()
                      ? AppColors.backgrounddark
                      : AppColors.backgroundlight,
                  border: Border.all(
                    color: provider.isDark()
                        ? AppColors.darkblue
                        : AppColors.lightgray,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 9.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.event.title,
                        style: theme.titleMedium?.copyWith(
                          fontSize: 14,
                          color: provider.isDark()
                              ? AppColors.white
                              : AppColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.event.isfavourite =
                                !widget.event.isfavourite;
                            FirebaseCloudService.update(widget.event);
                          });
                        },
                        child: widget.event.isfavourite == true
                            ? Assets.icons.heart.svg(
                                colorFilter: ColorFilter.mode(
                                  provider.isDark()
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight,
                                  BlendMode.srcIn,
                                ),
                              )
                            : Assets.icons.heartnofav.svg(
                                colorFilter: ColorFilter.mode(
                                  provider.isDark()
                                      ? AppColors.primaryDark
                                      : AppColors.primaryLight,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
