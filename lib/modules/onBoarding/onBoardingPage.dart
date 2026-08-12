import 'package:eventlyapp/core/AppRoutes/AppRouteName.dart';
import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:eventlyapp/core/utilities/Widgets/AppButton.dart';
import 'package:eventlyapp/modules/onBoarding/changedelement.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../../core/gen/assets.gen.dart';
import '../../core/themes/AppColors.dart';
import '../../core/utilities/checkonboarding.dart';
import 'DataPage.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() {
    return _onBoardingState();
  }
}

class _onBoardingState extends State<onBoarding> {
  int currentindex = 0;

  PageController controller = PageController();

  List<DataPage> pages = [
    DataPage(
      images: Assets.images.hotTrending.image(),
      mainTxt: "Find Events That Inspire You",
      subTxt:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),

    DataPage(
      images: Assets.images.managerDesk.image(),
      mainTxt: "Effortless Event Planning",
      subTxt:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    DataPage(
      images: Assets.images.a3333.image(),
      mainTxt: "Connect with Friends & Share Moments",
      subTxt:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];

  Widget build(BuildContext context) {
    final themeprimarycolor = Theme.of(context).primaryColor;
    final themesecondarycolor = Theme.of(context).secondaryHeaderColor;
    final headlinecolor = Theme.of(context).canvasColor;
    final unselectioncontainer = Theme.of(context).shadowColor;
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: currentindex != 0
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
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
              )
            : SizedBox(),
        leadingWidth: 80,

        title: SizedBox(
          width: 142,
          height: 27,
          child: Assets.images.evently.image(color: themeprimarycolor),
        ),

        centerTitle: true,

        actions: [
          currentindex != 2
              ? Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        CheckOnBoarding.setSeen();
                      });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouteName.Login,
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: 63,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: provider.isDark()
                              ? AppColors.primaryLight
                              : AppColors.lightgray,
                        ),
                        color: provider.isDark()
                            ? AppColors.backgrounddark
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Skip",
                          style: theme.titleLarge?.copyWith(
                            fontSize: 14,
                            color: provider.isDark()
                                ? AppColors.white
                                : AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentindex = index;
                  });
                },
                controller: controller,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Changedelement(
                    currentindex: index,
                    page: pages[index],
                  );
                },
              ),
            ),

            AppButton(
              text: currentindex == 2 ? "Get Started" : "Next",
              ontap: () {
                if (currentindex == 0 || currentindex == 1) {
                  setState(() {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                } else if (currentindex == 2) {
                  setState(() {
                    CheckOnBoarding.setSeen();
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouteName.Login,
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
