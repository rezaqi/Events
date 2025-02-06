import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/widget/home/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  late bool isDarkMode;
  bool _isLogIn = false;
  int i = 0;
  var selectedDate = DateTime.now();
  var selectedTimer = TimeOfDay.now();

  bool get isLogIn => _isLogIn;

  String? userId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  MyProvider() {
    _loadingTheme();
    checkAuth();
    getIdUser();
  }

  changeTimer(TimeOfDay timer) {
    selectedTimer = timer;
    notifyListeners();
  }

  changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  changeIi() {
    i = changeI.i;
    notifyListeners();
  }

  getIdUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userId = sharedPreferences.getString("user");
    notifyListeners();
  }

  Future<void> checkAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogIn = prefs.containsKey("user");
    print(_isLogIn);
    notifyListeners();
  }

  Future<void> _loadingTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("Theme_mode") == "light") {
      themeMode = ThemeMode.light;
      isDarkMode = false;
    } else {
      themeMode = ThemeMode.dark;
      isDarkMode = true;
    }
    notifyListeners();
  }

  void changeThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    if (themeMode == ThemeMode.light) {
      prefs.setString("Theme_mode", "light");
    } else {
      prefs.setString("Theme_mode", "dark");
    }
    notifyListeners();
  }

  void changeThemeModeToLight() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.light;

    prefs.setString("Theme_mode", "light");

    notifyListeners();
  }

  void changeThemeModeToDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.dark;

    prefs.setString("Theme_mode", "dark");

    notifyListeners();
  }

  changeLanguage(
    BuildContext context,
  ) {
    if (context.locale == Locale("en")) {
      context.setLocale(Locale("ar"));
    } else {
      context.setLocale(Locale("en"));
    }
    notifyListeners();
  }
}
