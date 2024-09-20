import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/goRouter.dart';

class AuthManager {
  Future saveUidToSharedPreference(String uid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("uid", uid);
  }

  Future getUidFromSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get("uid");
  }

  Future checkLogIn(BuildContext context) async {
    String? uid = await getUidFromSharedPreference();

    if (uid != null) {
      GoRouter.of(context).push(AppRouter.taskHomeScreen);
    } else {
      GoRouter.of(context).push(AppRouter.logInScreen);
    }
  }

  Future logOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("uid");
    FirebaseAuth.instance.signOut();
    GoRouter.of(context)
        .push(AppRouter.logInScreen); // الانتقال إلى شاشة تسجيل الدخول
  }

  Future<void> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', user.uid);
        GoRouter.of(context).pushReplacement(AppRouter.taskHomeScreen);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));    }
  }

  Future saveUserData(
      {required String name,
      required String email,
      required int? experience,
      required String level,
      required String address,
      required String password}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'yearsOfExperience': experience,
        'level': level,
        'address': address,
        'password': password,
      });
    }
  }
}
