import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/settingsProvider.dart';
import '../../core/themes/AppColors.dart';
import '../../core/utiles/firebasecloudservice.dart';
import '../AddEvent/EventData.dart';
import '../Home/EventCardItem.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  State<Favourite> createState() {
    return _FavouriteState();
  }
}

class _FavouriteState extends State<Favourite> {
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),

              SizedBox(
                height: 48,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    cursorColor: provider.isDark()
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,

                    style: TextStyle(
                      color: provider.isDark()
                          ? AppColors.white
                          : AppColors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: provider.isDark()
                            ? AppColors.primaryDark
                            : AppColors.primaryLight,
                      ),

                      hintText: "Search for event",
                      hintStyle: theme.titleSmall?.copyWith(
                        color: provider.isDark()
                            ? AppColors.lightgray
                            : AppColors.darkgrey,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: provider.isDark()
                          ? AppColors.backgrounddark
                          : AppColors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: provider.isDark()
                              ? AppColors.darkblue
                              : AppColors.lightgray,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: provider.isDark()
                              ? AppColors.darkblue
                              : AppColors.lightgray,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              StreamBuilder(
                stream: FirebaseCloudService.getfavourites(),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.hasError.toString());
                  }

                  List<EventData> eventdatalist = snapshot.data!.docs
                      .map((item) => item.data())
                      .toList();
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
                },
              ),

              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: 6,
              //   itemBuilder: (context , index){
              //     return EventCardItem(event: null,) ;
              //   }, separatorBuilder: ( context,  index) {
              //   return   SizedBox(height: 16) ;
              // },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
