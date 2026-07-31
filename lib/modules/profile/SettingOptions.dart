import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/settingsProvider.dart';
import '../../core/themes/AppColors.dart';

class SettingOptions extends StatefulWidget {
  final String optionname;

  final Widget optionicon;

  const SettingOptions({
    super.key,
    required this.optionname,
    required this.optionicon,
  });

  State<SettingOptions> createState() {
    return _SettingOptionsState();
  }
}

class _SettingOptionsState extends State<SettingOptions> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: provider.isDark() ? AppColors.backgrounddark : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: provider.isDark() ? AppColors.darkblue : AppColors.lightgray,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.optionname,
                style: theme.titleMedium?.copyWith(
                  color: provider.isDark() ? AppColors.white : AppColors.black,
                  fontSize: 16,
                ),
              ),
              widget.optionicon,
            ],
          ),
        ),
      ),
    );
  }
}
