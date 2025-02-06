import 'package:evently/core/class/routs_name.dart';
import 'package:evently/screen/add.dart';
import 'package:evently/screen/anb.dart';
import 'package:evently/screen/auth/forget_pass.dart';
import 'package:evently/screen/auth/login.dart';
import 'package:evently/screen/auth/signup.dart';
import 'package:evently/screen/onboarding.dart';
import 'package:evently/screen/theme_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> route = {
  AppRouts.theme: (context) => ThemePage(),
  AppRouts.onboarding: (context) => OnBoarding(),
  AppRouts.home: (context) => ANB(),
  AppRouts.login: (context) => LogIn(),
  AppRouts.signup: (context) => SignUp(),
  AppRouts.forgtPass: (context) => ForgetPass(),
  AppRouts.addEvent: (context) => AddEvent()
};
