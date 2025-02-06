import 'package:evently/core/class/colors.dart';
import 'package:evently/core/static/text/dark.dart';
import 'package:flutter/material.dart';

ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: AppColorsDark.background,
    textTheme: textThemeDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsDark.background,
      centerTitle: true,
    ));
