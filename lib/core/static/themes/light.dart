import 'package:evently/core/class/colors.dart';
import 'package:evently/core/static/text/text_theme.dart';
import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      centerTitle: true,
    ));
