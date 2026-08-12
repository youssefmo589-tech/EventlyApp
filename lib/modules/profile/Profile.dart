import 'dart:io';

import 'package:eventlyapp/core/utiles/FirebaseFireStorage.dart';
import 'package:eventlyapp/core/utiles/userfirestore.dart';
import 'package:eventlyapp/modules/profile/SettingOptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/AppRoutes/AppRouteName.dart';
import '../../core/provider/settingsProvider.dart';
import '../../core/themes/AppColors.dart';
import '../users/UserModel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  State<Profile> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  bool status = false;
  UserModel ? user;

  void initState() {
    super.initState();
    loaduser();
  }

  void loaduser() async
  {
    final doc = await Userfirestore.getuser(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      user = doc;
    });
  }

  File ? image;

  ImagePicker picker = ImagePicker();

  Future<void> pick() async
  {
    final XFile? pickedimage = await picker.pickImage(
        source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
      final imageurl = await FireStorageService.uploadimage(
          FirebaseAuth.instance.currentUser!.uid, image!);
      await Userfirestore.updateuserimage(
          FirebaseAuth.instance.currentUser!.uid, imageurl);
    }
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 32),
            GestureDetector(
                onTap: () {
                  pick();
                },
                child: Container(
                    width: 116,
                    height: 116,
                    decoration: BoxDecoration(
                      color: image == null ? AppColors.lightgray : Colors
                          .transparent,
                      shape: BoxShape.circle,
                      image: image != null ? DecorationImage(
                        image: FileImage(File(image!.path)),
                        fit: BoxFit.contain,
                      ) : user?.image != null ? DecorationImage(
                          image: NetworkImage(user!.image!),
                          fit: BoxFit.contain) : null,
                    ),
                    child: image == null && user?.image == null
                        ? Icon(Icons.person, size: 70, color: AppColors.white,)
                        : SizedBox()
                )

            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                user?.name ?? "",
                style: theme.titleLarge?.copyWith(
                  color: provider.isDark() ? AppColors.white : AppColors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 4),
            Center(
              child: Text(
                user?.email ?? "",
                style: theme.titleSmall?.copyWith(
                  color: provider.isDark()
                      ? AppColors.lightgray
                      : AppColors.darkgrey,
                  fontSize: 14,
                ),
              ),
            ),
            SettingOptions(
              optionname: "Dark Mode",
              optionicon: FlutterSwitch(
                activeColor: provider.isDark()
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,

                width: 60,
                height: 32,
                valueFontSize: 25.0,
                toggleSize: 30,
                toggleColor: provider.isDark()
                    ? AppColors.white
                    : AppColors.primaryLight,
                value: status,
                borderRadius: 30.0,
                padding: 0,
                showOnOff: false,
                onToggle: (val) {
                  provider.isDark()
                      ? provider.changeThemeMode(ThemeMode.light)
                      : provider.changeThemeMode(ThemeMode.dark);
                  setState(() {
                    status = val;
                  });
                },
              ),
            ),

            SettingOptions(
              optionname: "Language",
              optionicon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: provider.isDark()
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouteName.Login, (route) => false);
              },

              child: SettingOptions(
                optionname: "Logout",
                optionicon: Icon(Icons.logout_outlined, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
