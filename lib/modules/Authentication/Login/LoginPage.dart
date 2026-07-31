// import 'package:eventlyapp/core/AppRoutes/AppRouteName.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import '../../../core/gen/assets.gen.dart';
// import '../../../core/themes/AppColors.dart';
// import '../../../core/utilities/AuthService.dart';
//
// class LoginPage extends StatefulWidget
// {
//   const LoginPage({super.key});
//
//   State<LoginPage>createState()
//   {
//     return _LoginPageState();
//   }
// }
//
// class _LoginPageState extends State<LoginPage>
// {
//   TextEditingController email = TextEditingController() ;
//   TextEditingController pass = TextEditingController() ;
//
//
//   bool ishidden  =false ;
//   final _formkey = GlobalKey<FormState>() ;
//   Widget build(BuildContext context)
//   {
//     final theme = Theme.of(context).textTheme ;
//     return Scaffold(
//       appBar: AppBar(
//
//         title:  Padding(
//           padding: const EdgeInsets.symmetric( horizontal: 16),
//           child: SizedBox(
//               width: 142,
//               height: 27,
//               child: Assets.images.evently.image()),
//         ),
//         centerTitle: true ,
//
//
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 48,) ,
//               Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text("Login to your account" , style: theme.titleLarge?.copyWith(fontSize: 24 , color: AppColors.primaryLight),)) ,
//               SizedBox(height: 24,) ,
//               Form(
//                 key: _formkey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUnfocus,
//                       validator: (value){
//                         if(value == null || value.isEmpty)
//                           {
//                             return "please enter your email" ;
//                           }
//                         if(checkemail(email)==false)
//                           {
//                             return "your email is not correct" ;
//                           }
//                       },
//                       controller: email ,
//                      cursorColor: AppColors.primaryLight,
//                       style: theme.titleSmall?.copyWith(color: AppColors.black , fontSize: 14),
//                       decoration:InputDecoration(
//                         errorStyle: TextStyle(color: Colors.red),
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.only(left: 18 , right: 10 , top: 15.5 , bottom: 15.5),
//                           child: Assets.icons.sms.svg(),
//                         ),
//                         contentPadding: EdgeInsets.only(top: 13.5 , bottom: 13.5 , left: 48),
//                         filled: true ,
//                         fillColor: AppColors.white ,
//                         hintText: "Enter your email" ,
//                         hintStyle:theme.titleSmall?.copyWith(color: AppColors.darkgrey , fontSize: 14),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(16) ,
//                           borderSide: BorderSide(color: AppColors.lightgray, width: 1) ,
//
//                         ) ,
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16) ,
//                             borderSide: BorderSide(color: AppColors.lightgray , width: 1) ,
//
//                       )
//                       )
//
//                     ),
//
//
//
//
//               SizedBox(height: 16,) ,
//
//               TextFormField(
//
//                 autovalidateMode: AutovalidateMode.onUnfocus,
//                 validator: (value){
//                   if(value == null || value.isEmpty)
//                     {
//                       return "please enter your password" ;
//
//                     }
//                    if(checkpass(pass)==false)
//                     {
//                       return "your password is not correct" ;
//                     }
//                 },
//                 obscureText: ishidden,
//                 controller: pass,
//                   cursorColor: AppColors.primaryLight,
//                   style: theme.titleSmall?.copyWith(color: AppColors.black , fontSize: 14),
//                   decoration:InputDecoration(
//                     errorStyle: TextStyle(color:Colors.red),
//                     suffixIcon: IconButton(
//                         onPressed: (){
//                           setState(() {
//                             ishidden = !ishidden ;
//                           });
//
//                         },
//                         icon:ishidden == false ? Icon(Icons.visibility) : Icon(Icons.visibility_off)  ,
//
//                     ),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.only(left: 18 , right: 10 , top: 15.5 , bottom: 15.5),
//                         child: Assets.icons.lock.svg(),
//                       ),
//                       contentPadding: EdgeInsets.only(top: 13.5 , bottom: 13.5 , left: 48),
//                       filled: true ,
//                       fillColor: AppColors.white ,
//                       hintText: "Enter your password" ,
//                       hintStyle:theme.titleSmall?.copyWith(color: AppColors.darkgrey , fontSize: 14),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16) ,
//                         borderSide: BorderSide(color: AppColors.lightgray , width: 1) ,
//
//                       ) ,
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16) ,
//                         borderSide: BorderSide(color:  AppColors.lightgray , width: 1) ,
//
//                       )
//                   )
//
//               ) ,
//                 ]
//         ) ,
//               )  ,
//               SizedBox(height: 8,) ,
//               Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                       onTap: (){
//
//
//                       },
//                       child: Text("Forget Password?" , style: theme.titleLarge?.copyWith(color: AppColors.primaryLight , fontSize: 14),))) ,
//
//           SizedBox(height: 47,) ,
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryLight ,
//
//                     ) ,
//                     onPressed: () async{
//
//                       if(_formkey.currentState!.validate())
//                       {
//                         final usercredential = await AuthService().signinWithEmailAndPassword(email: email.text.trim(), password: pass.text);
//                       }
//
//                     },
//
//                     child:Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 9),
//                       child: Text("Login" , style: theme.titleMedium?.copyWith(fontSize: 20 , color: AppColors.white),),
//                     ), ),
//               ) ,
//               SizedBox(height: 48,) ,
//              Text.rich(TextSpan(
//                children: [
//                  TextSpan(
//                    text: "Don’t have an account ?" ,
//                    style: theme.titleSmall?.copyWith(color: AppColors.darkgrey)
//                  ) ,
//                  TextSpan(
//                    text: "Signup" ,
//                    style:theme.titleSmall?.copyWith(color: AppColors.primaryLight , fontWeight: FontWeight.w600) ,
//                    recognizer: TapGestureRecognizer()..onTap =  (){
//                      Navigator.of(context).pushNamedAndRemoveUntil(AppRouteName.SignUP, (route)=> false) ;
//                    }
//                  )
//
//                ]
//
//              )) ,
//               SizedBox(height: 32,) ,
//               Text("Or" , style: theme.titleMedium?.copyWith(color: AppColors.primaryLight),) ,
//               SizedBox(height: 32,) ,
//
//
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.white ,
//
//                   ) ,
//                   onPressed: () async {
//
//                         final usercredential = await AuthService().signinWithGoogle() ;
//                         if(usercredential != null)
//                         {
//                           // navigate to home
//                         }
//
//
//                   },
//
//                   child:Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 9),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                        SizedBox(
//                          width: 24 , height: 24,
//                              child: Assets.images.image6.image(),
//                            ) ,
//                           SizedBox(width: 16,) ,
//
//
//                           Text("Login with Google" , style: theme.titleMedium?.copyWith(fontSize: 18 , color: AppColors.primaryLight),),
//
//                       ],
//                     ),
//                   ), ),
//               ) ,
//
//                 ],
//
//           ),
//         ),
//       ),
//
//
//     );
//
//   }
//   bool checkemail(TextEditingController email)
//   {
//     String txt = email.text ;
//     RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') ;
//     if(regex.hasMatch(txt))
//       {
//
//         return true ;
//       }
//
//
//     return false ;
//
//   }
//   bool checkpass(TextEditingController pass)
//   {
//     String txt = pass.text ;
//     if(!txt.contains(RegExp(r'[A-Z]')))
//     {
//
//       return false ;
//     }
//     if(!txt.contains(RegExp(r'[a-z]')))
//     {
//
//       return false ;
//     }
//     if(!txt.contains(RegExp(r'[0-9]')))
//       {
//
//         return false ;
//       }
//     if(!txt.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
//       {
//
//         return false ;
//       }
//     if(txt.length < 8)
//       {
//
//         return false ;
//       }
//
//
//     return true ;
//   }
//
//
// }

import 'package:eventlyapp/core/AppRoutes/AppRouteName.dart';
import 'package:eventlyapp/core/provider/settingsProvider.dart';
import 'package:eventlyapp/core/services/snackBarServices.dart';
import 'package:eventlyapp/core/utilities/Widgets/Field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../../core/gen/assets.gen.dart';
import '../../../core/themes/AppColors.dart';
import '../../../core/utilities/AuthService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  bool ishidden = false;

  final _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final provider = Provider.of<settingProvider>(context);
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
                  "Login to your account",
                  style: theme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: provider.isDark()
                        ? AppColors.white
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
                      hinttext: "Enter your email",
                      controller: email,
                      prefix: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 10,
                          top: 15.5,
                          bottom: 15.5,
                        ),
                        child: Assets.icons.sms.svg(
                          colorFilter: ColorFilter.mode(
                            AppColors.lightgray,
                            BlendMode.srcIn,
                          ),
                        ),
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
                  ],
                ),
              ),

              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouteName.ForgetPassword);
                  },
                  child: Text(
                    "Forget Password?",
                    style: theme.titleLarge?.copyWith(
                      color: provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 47),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.isDark()
                        ? AppColors.primaryDark
                        : AppColors.primaryLight,
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      EasyLoading.show();
                      bool success = await AuthService.signInwithAccount(
                        email.text,
                        pass.text,
                      );
                      if (success) {
                        EasyLoading.dismiss();
                        AppSnackBar.success("login successed");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouteName.Layout,
                          (route) => false,
                        );
                      } else {
                        EasyLoading.dismiss();
                        AppSnackBar.error("login failed");
                      }
                    }
                  },

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Text(
                      "Login",
                      style: theme.titleMedium?.copyWith(
                        fontSize: 20,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an account ?",
                      style: theme.titleSmall?.copyWith(
                        color: provider.isDark()
                            ? AppColors.lightgray
                            : AppColors.darkgrey,
                      ),
                    ),
                    TextSpan(
                      text: "Signup",
                      style: theme.titleSmall?.copyWith(
                        color: provider.isDark()
                            ? AppColors.primaryDark
                            : AppColors.primaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouteName.SignUP,
                            (route) => false,
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    color: provider.isDark()
                        ? AppColors.darkblue
                        : AppColors.lightgray,
                    endIndent: 20,
                    thickness: 1,
                  ),
                  Text(
                    "Or",
                    style: theme.titleMedium?.copyWith(
                      color: provider.isDark()
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                    ),
                  ),
                  Divider(
                    color: provider.isDark()
                        ? AppColors.darkblue
                        : AppColors.lightgray,
                    indent: 20,
                    thickness: 1,
                  ),
                ],
              ),

              SizedBox(height: 32),

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
                    final usercredential = await AuthService()
                        .signinWithGoogle();
                    if (usercredential != null) {
                      // navigate to home
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
                          "Login with Google",
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
