import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../modules/onBoarding/onBoardingPage.dart' as AppRouteName;
import '../../themes/AppColors.dart';

class AppButton extends StatefulWidget {
  final String text;

  final Function() ontap;

  const AppButton({super.key, required this.text, required this.ontap});

  State<AppButton> createState() {
    return _AppButtonState();
  }
}

class _AppButtonState extends State<AppButton> {
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final themeprimarycolor = Theme.of(context).primaryColor;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: themeprimarycolor),
        onPressed: () {
          setState(() {
            widget.ontap();
          });
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Text(
              widget.text,
              style: theme.titleMedium?.copyWith(
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
