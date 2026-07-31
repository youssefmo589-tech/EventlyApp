import 'package:bot_toast/bot_toast.dart';
import 'package:eventlyapp/core/AppRoutes/App_Config.dart';
import 'package:eventlyapp/core/themes/AppTheme%20Manager.dart';
import 'package:eventlyapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'core/AppRoutes/AppRouteName.dart';
import 'core/provider/settingsProvider.dart';
import 'core/services/loadingservices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => settingProvider(),
      child: MyApp(),
    ),
  );

  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    final settingProvider provider = Provider.of<settingProvider>(context);
    return MaterialApp(
      builder: EasyLoading.init(builder: BotToastInit()),
      debugShowCheckedModeBanner: false,
      themeMode: provider.currentThemeMode,
      theme: AppThemeManager.getlighttheme,
      darkTheme: AppThemeManager.getdarktheme,
      initialRoute: AppRouteName.initial,
      onGenerateRoute: AppConfig.onGenerateRoute,

      // home:Layout()  ,
    );
  }
}
