import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

changeLanguage(
  BuildContext context,
) {
  if (context.locale == Locale("en")) {
    context.setLocale(Locale("ar"));
  } else {
    context.setLocale(Locale("en"));
  }
}
