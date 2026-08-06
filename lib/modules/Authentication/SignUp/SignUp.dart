import 'package:eventlyapp/core/services/snackBarServices.dart';
import 'package:eventlyapp/core/utiles/userfirestore.dart';
import 'package:eventlyapp/core/utilities/AuthService.dart';
import 'package:eventlyapp/core/utilities/Widgets/AppButton.dart';
import 'package:eventlyapp/modules/users/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../core/AppRoutes/AppRouteName.dart';
import '../../../core/gen/assets.gen.dart';
import '../../../core/provider/settingsProvider.dart';
import '../../../core/themes/AppColors.dart';
import '../../../core/utilities/Widgets/Field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  bool ishidden = true;

  bool ishidden2 = true;

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController confirmpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<settingProvider>(context);
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: 142,
            height: 27,
            child: Assets.images.evently.image(
              color: provider.isDark()
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create your account",
                  style: theme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: provider.isDark()
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Form(
                key: _formkey,

                child: Column(
                  children: [
                    CustomeField(
                      hinttext: "Enter your name",
                      controller: name,
                      prefix: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 10,
                          top: 15.5,
                          bottom: 15.5,
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: AppColors.lightgray,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your name";
                        }
                      },
                    ),

                    SizedBox(height: 16), ///////////////

                    CustomeField(
                      hinttext: "Enter your email",
                      controller: email,
                      prefix: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 10,
                          top: 15.5,
                          bottom: 15.5,
                        ),
                        child: Assets.icons.sms.svg(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your email";
                        }
                        if (checkemail(email) == false) {
                          return "your email is not correct";
                        }
                      },
                    ),

                    SizedBox(height: 16),
                    CustomeField(
                      obsecuretext: ishidden,
                      hinttext: "Enter your password",
                      controller: pass,
                      ispass: true,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            ishidden = !ishidden;
                          });
                        },
                        icon: ishidden == false
                            ? Icon(
                                Icons.visibility,
                                color: provider.isDark()
                                    ? AppColors.lightgray
                                    : AppColors.darkgrey,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: provider.isDark()
                                    ? AppColors.lightgray
                                    : AppColors.darkgrey,
                              ),
                      ),
                      prefix: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 10,
                          top: 15.5,
                          bottom: 15.5,
                        ),
                        child: Assets.icons.lock.svg(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        }
                        if (checkpass(pass) == false) {
                          return "your password is not correct";
                        }
                      },
                    ),

                    SizedBox(height: 16),

                    CustomeField(
                      obsecuretext: ishidden2,
                      hinttext: "Confirm your password",
                      controller: confirmpass,
                      ispassconfirm: true,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            ishidden2 = !ishidden2;
                          });
                        },
                        icon: ishidden2 == false
                            ? Icon(
                                Icons.visibility,
                                color: provider.isDark()
                                    ? AppColors.lightgray
                                    : AppColors.darkgrey,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: provider.isDark()
                                    ? AppColors.lightgray
                                    : AppColors.darkgrey,
                              ),
                      ),
                      prefix: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 10,
                          top: 15.5,
                          bottom: 15.5,
                        ),
                        child: Assets.icons.lock.svg(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        }
                        if (pass.text != confirmpass.text) {
                          return "your password is not compatible";
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              AppButton(
                text: "Sign up",
                ontap: () async {
                  // navigate to layout
                  EasyLoading.show();

                  if (_formkey.currentState!.validate()) {
                    bool success = await AuthService.createAccount(
                      email.text,
                      pass.text,
                    );

                    final user = UserModel(name: name.text,
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        email: email.text);
                    bool iscreated = await Userfirestore.createUser(user);


                    if (success == true && iscreated == true) {
                      EasyLoading.dismiss();
                      AppSnackBar.success("Create Account Success");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouteName.Layout,
                            (route) => false,
                      );
                    } else {
                      EasyLoading.dismiss();
                      AppSnackBar.error("Create Account Failed");
                    }
                  }
                },
              ),

              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account?",
                      style: theme.titleSmall?.copyWith(
                        color: provider.isDark()
                            ? AppColors.lightgray
                            : AppColors.darkgrey,
                      ),
                    ),
                    TextSpan(
                      text: "Login",
                      style: theme.titleSmall?.copyWith(
                        color: provider.isDark()
                            ? AppColors.primaryDark
                            : AppColors.primaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouteName.Login,
                            (route) => false,
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Or",
                style: theme.titleMedium?.copyWith(
                  color: provider.isDark()
                      ? AppColors.primaryDark
                      : AppColors.primaryLight,
                ),
              ),
              SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.isDark()
                        ? AppColors.backgrounddark
                        : AppColors.white,
                    side: BorderSide(
                      color: provider.isDark()
                          ? AppColors.darkblue
                          : AppColors.lightgray,
                      width: 2,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await AuthService().signinWithGoogle();
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      final user = await Userfirestore.getuser(uid);
                      if (user == null) {
                        final newuser = UserModel(name: FirebaseAuth.instance
                            .currentUser!.displayName ?? "",
                            uid: uid,
                            email: FirebaseAuth.instance.currentUser!.email ??
                                "");
                        await Userfirestore.createUser(newuser);

                        AppSnackBar.success("Sign in success");
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRouteName.Layout, (route) => false);
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRouteName.Layout, (route) => false);
                    } catch (error) {
                      AppSnackBar.error("Sign in failed");
                    }
                  },

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Assets.images.image6.image(),
                        ),
                        SizedBox(width: 16),

                        Text(
                          "Sign up with Google",
                          style: theme.titleMedium?.copyWith(
                            fontSize: 18,
                            color: provider.isDark()
                                ? AppColors.primaryDark
                                : AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkemail(TextEditingController email) {
    String txt = email.text;
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (regex.hasMatch(txt)) {
      return true;
    }

    return false;
  }

  bool checkpass(TextEditingController pass) {
    String txt = pass.text;
    if (!txt.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!txt.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (!txt.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    if (!txt.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    if (txt.length < 8) {
      return false;
    }

    return true;
  }
}
