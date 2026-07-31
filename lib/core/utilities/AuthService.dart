import 'dart:async';

import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/snackBarServices.dart';

// class AuthService
// {
//   Future<UserCredential?>SignInWithGoogle()async
//   {
//    final GoogleSignInAccount ? googleuser = await GoogleSignIn().signIn() ;
//    if(googleuser == null)
//      {
//        return null ;
//      }
//    final GoogleSignInAuthentication googleAuth = await googleuser.authentication ;
//    final AuthCredential credential = GoogleAuthProvider.credential(
//      accessToken: googleAuth.accessToken  ,
//      idToken: googleAuth.idToken  ,
//    ) ;
//    return await FirebaseAuth.instance.signInWithCredential (credential ,) ;
//   }
// }

class AuthService {
  Future<UserCredential?> signinWithGoogle() async {
    final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    if (googleuser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleuser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<bool> createAccount(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppSnackBar.error("The password provided is too weak.");
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        AppSnackBar.error("The account already exists for that email");
        return Future.value(false);
      }
    } catch (e) {
      AppSnackBar.error("something went wrong");
      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> signInwithAccount(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppSnackBar.error("No user found for that email");
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        AppSnackBar.error("Wrong password provided for that user");
        return Future.value(false);
      }
    }
    return Future.value(false);
  }
}
