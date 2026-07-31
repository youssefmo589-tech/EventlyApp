import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/themes/AppColors.dart';
import 'DataPage.dart';

class Changedelement extends StatefulWidget {
  final int currentindex;

  final DataPage page;

  const Changedelement({
    super.key,
    required this.currentindex,
    required this.page,
  });

  State<Changedelement> createState() {
    return _ChangedelementState();
  }
}

class _ChangedelementState extends State<Changedelement> {
  Widget build(BuildContext context) {
    final themeprimarycolor = Theme.of(context).primaryColor;
    final themesecondarycolor = Theme.of(context).secondaryHeaderColor;
    final headlinecolor = Theme.of(context).canvasColor;
    final unselectioncontainer = Theme.of(context).shadowColor;
    final provider = Provider.of<settingProvider>(context);

    final theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: widget.page.images.image,
          color: provider.isDark() ? AppColors.white : AppColors.primaryLight,
          colorBlendMode: BlendMode.srcIn,
        ),

        // widget.page.images ,
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              width: widget.currentindex == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: widget.currentindex == index
                    ? themeprimarycolor
                    : provider.isDark()
                    ? AppColors.white
                    : AppColors.lightgray,
              ),
              margin: EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        ),

        SizedBox(height: 16),
        Text(
          widget.page.mainTxt,
          style: theme.titleLarge?.copyWith(color: headlinecolor),
        ),
        SizedBox(height: 8),
        Text(
          widget.page.subTxt,
          style: theme.titleSmall?.copyWith(color: themesecondarycolor),
        ),
      ],
    );
  }
}
