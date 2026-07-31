import 'package:eventlyapp/category%20data%20source/CategoryDataSource.dart';
import 'package:eventlyapp/core/utiles/firebasecloudservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/gen/assets.gen.dart';
import '../../core/provider/settingsProvider.dart';
import '../../core/themes/AppColors.dart';
import '../AddEvent/EventData.dart';
import 'EventCardItem.dart';
import 'TabBarItem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _selectedindex = 0;

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            spacing: 24,
            children: [
              SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back ✨",
                          style: theme.titleSmall?.copyWith(
                            color: provider.isDark()
                                ? AppColors.lightgray
                                : AppColors.darkgrey,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Youssef Mohamed",
                          style: theme.titleMedium?.copyWith(
                            color: provider.isDark()
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        provider.isDark() == false
                            ? GestureDetector(
                                onTap: () {
                                  provider.changeThemeMode(ThemeMode.dark);
                                },
                                child: Assets.icons.sun.svg(
                                  colorFilter: ColorFilter.mode(
                                    AppColors.primaryLight,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  provider.changeThemeMode(ThemeMode.light);
                                },

                                child: Assets.icons.moon.svg(
                                  colorFilter: ColorFilter.mode(
                                    AppColors.primaryDark,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),

                        SizedBox(width: 10),
                        Container(
                          width: 34,
                          height: 32,
                          decoration: BoxDecoration(
                            color: provider.isDark()
                                ? AppColors.primaryDark
                                : AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "EN",
                              style: theme.titleLarge?.copyWith(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              DefaultTabController(
                length: CategoryDataSource.Categories.length,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      _selectedindex = index;
                    });
                  },
                  isScrollable: true,
                  indicator: BoxDecoration(),
                  dividerHeight: 0,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  tabs: CategoryDataSource.Categories.map(
                    (item) => TabBarItem(
                      item: item,
                      isselected:
                          _selectedindex ==
                              CategoryDataSource.Categories.indexOf(item)
                          ? true
                          : false,
                    ),
                  ).toList(),
                ),
              ),

              StreamBuilder(
                stream: FirebaseCloudService.getRealtimeEventData(
                  CategoryDataSource.Categories[_selectedindex].id,
                ),

                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  List<EventData> eventdatalist =
                      snapshot.data!.docs.map((item) => item.data()).toList() ??
                      [];

                  if (eventdatalist.isEmpty) {
                    return Text("No EVENTS");
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventdatalist.length,
                    itemBuilder: (context, index) {
                      return EventCardItem(event: eventdatalist[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                  );
                }),
              ),

              // FutureBuilder(
              //
              //     future: FirebaseCloudService.getevent(),
              //
              //     builder: ((context, snapshot) {
              //       if(snapshot.connectionState == ConnectionState.waiting)
              //         {
              //           return CircularProgressIndicator() ;
              //         }
              //       if(snapshot.hasError)
              //         {
              //           return Text(snapshot.error.toString()) ;
              //         }
              //
              //         List<EventData>eventdatalist = snapshot.data ?? [] ;
              //
              //       if(eventdatalist.isEmpty)
              //         {
              //           return Text("No EVENTS") ;
              //         }
              //       return ListView.separated(
              //             shrinkWrap: true,
              //                 physics: NeverScrollableScrollPhysics(),
              //             itemCount: eventdatalist.length,
              //                itemBuilder: (context , index){
              //                 return EventCardItem(
              //                   event: eventdatalist[index],
              //
              //                 ) ;
              //               }, separatorBuilder: ( context,  index) {
              //                 return   SizedBox(height: 16) ;
              //            },
              //
              //            );
              //
              //
              //
              //       }
              //     )
              //
              // )

              //  ListView.separated(
              //    shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       itemCount: 6,
              //     itemBuilder: (context , index){
              //       return EventCardItem() ;
              //     }, separatorBuilder: ( context,  index) {
              //       return   SizedBox(height: 16) ;
              // },
              //
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
