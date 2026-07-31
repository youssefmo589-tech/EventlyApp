import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/settingsProvider.dart';
import '../../themes/AppColors.dart';

class CustomeField extends StatefulWidget {
  final Widget? prefix;

  final bool obsecuretext;

  final int? maxlines;

  final Widget? suffix;

  final bool ispass;

  final ispassconfirm;

  final String hinttext;

  final FormFieldValidator<String>? validator;

  final TextEditingController? controller;

  CustomeField({
    super.key,
    required this.hinttext,
    this.controller,
    this.prefix,
    this.suffix,
    this.validator,
    this.ispass = false,
    this.obsecuretext = false,
    this.ispassconfirm = false,
    this.maxlines = 1,
  });

  State<CustomeField> createState() {
    return _CustomeFieldState();
  }
}

class _CustomeFieldState extends State<CustomeField> {
  Widget build(BuildContext context) {
    final provider = Provider.of<settingProvider>(context);

    final theme = Theme.of(context).textTheme;
    return TextFormField(
      maxLines: widget.maxlines,
      obscureText: widget.obsecuretext,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: widget.validator,
      controller: widget.controller,
      cursorColor: AppColors.primaryLight,
      style: theme.titleSmall?.copyWith(
        color: provider.isDark() ? AppColors.white : AppColors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        suffixIcon: widget.ispass == true || widget.ispassconfirm == true
            ? widget.suffix
            : SizedBox(),

        prefixIcon: widget.prefix,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        filled: true,
        fillColor: provider.isDark()
            ? AppColors.backgrounddark
            : AppColors.white,
        hintText: widget.hinttext,
        hintStyle: theme.titleSmall?.copyWith(
          color: provider.isDark() ? AppColors.lightgray : AppColors.darkgrey,
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: provider.isDark() ? AppColors.darkblue : AppColors.lightgray,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: provider.isDark() ? AppColors.darkblue : AppColors.lightgray,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
