import 'package:eventlyapp/category%20data%20source/CategoryDataSource.dart';
import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:eventlyapp/core/services/snackBarServices.dart';
import 'package:eventlyapp/core/utiles/firebasecloudservice.dart';
import 'package:eventlyapp/modules/AddEvent/EditEvent.dart';
import 'package:eventlyapp/modules/AddEvent/EventData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/themes/AppColors.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  State<EventDetails> createState() {
    return _EventDetailsState();
  }
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments as EventData;

    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 65,
          leading: Padding(
            padding: const EdgeInsets.only(left: 7),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: provider.isDark()
                        ? AppColors.primaryLight
                        : AppColors.lightgray,
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
          title: Text(
            "Event details",
            style: theme.titleMedium?.copyWith(
              color: provider.isDark() ? AppColors.white : AppColors.black,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark()
                    ? AppColors.backgrounddark
                    : AppColors.white,
                border: Border.all(
                  color: provider.isDark()
                      ? AppColors.primaryDark
                      : AppColors.lightgray,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEvent(event: event),
                    ),
                  );
                },
                child: Icon(
                  Icons.edit,
                  size: 24,
                  color: provider.isDark()
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: provider.isDark()
                    ? AppColors.backgrounddark
                    : AppColors.white,
                border: Border.all(
                  color: provider.isDark()
                      ? AppColors.primaryDark
                      : AppColors.lightgray,
                ),
              ),
              child: GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  bool isdeleted = await FirebaseCloudService.deleteevent(
                    event.eventid!,
                  );
                  if (isdeleted) {
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                    AppSnackBar.success("deleted successed");
                  } else {
                    EasyLoading.dismiss();
                    AppSnackBar.success("deleted failed");
                  }
                },
                child: Icon(Icons.delete_outline, size: 24, color: Colors.red),
              ),
            ),
            SizedBox(width: 16),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Container(
                height: 193,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: provider.isDark()
                        ? AppColors.darkblue
                        : AppColors.lightgray,
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      provider.isDark()
                          ? CategoryDataSource.Categories.firstWhere(
                              (item) => item.id == event.categoryId,
                            ).darkimage
                          : CategoryDataSource.Categories.firstWhere(
                              (item) => item.id == event.categoryId,
                            ).image,
                    ),
                  ),
                ),
              ),
              Text(
                event.title,
                style: theme.titleMedium?.copyWith(
                  color: provider.isDark() ? AppColors.white : AppColors.black,
                  fontSize: 18,
                ),
              ),
              Container(
                height: 76,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: provider.isDark()
                      ? AppColors.backgrounddark
                      : AppColors.white,
                  border: Border.all(
                    color: provider.isDark()
                        ? AppColors.darkblue
                        : AppColors.lightgray,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
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
                        child: Icon(
                          Icons.calendar_month,
                          size: 24,
                          color: provider.isDark()
                              ? AppColors.primaryDark
                              : AppColors.primaryLight,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              "dd,MMMM",
                            ).format(event.selecteddatetime!),
                            style: theme.titleMedium?.copyWith(
                              fontSize: 16,
                              color: provider.isDark()
                                  ? AppColors.primaryDark
                                  : AppColors.black,
                            ),
                          ),
                          Text(
                            event.selectedtime!.format(context),
                            style: theme.titleMedium?.copyWith(
                              fontSize: 16,
                              color: provider.isDark()
                                  ? AppColors.lightgray
                                  : AppColors.darkgrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    "Description ",
                    style: theme.titleMedium?.copyWith(
                      color: provider.isDark()
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: provider.isDark()
                          ? AppColors.backgrounddark
                          : AppColors.white,
                      border: Border.all(
                        color: provider.isDark()
                            ? AppColors.darkblue
                            : AppColors.lightgray,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        event.descreption,
                        style: theme.titleSmall?.copyWith(
                          color: provider.isDark()
                              ? AppColors.lightgray
                              : AppColors.black,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
