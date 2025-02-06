import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/provider/provider.dart';
import 'package:evently/widget/customs/button.dart';
import 'package:evently/widget/customs/choose.dart';
import 'package:evently/widget/theme_app/languge.dart';
import 'package:evently/widget/theme_app/page_theme_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isLight = true;

  void initState() {
    loadingIsDark();
    super.initState();
  }

  loadingIsDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("Theme_mode") == "light") {
      isLight = true;
    } else {
      isLight = false;
    }
    setState(() {});
  }

  bool isEn = true;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    MyProvider provider = Provider.of<MyProvider>(context);
    isEn = context.locale.toString() == 'ar' ? false : true;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(AppImages.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThemePageImage(),
              Text(
                context.tr("theme_title"),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "theme_description".tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Column(
                spacing: h / 70,
                children: [
                  Language(
                    ontap1: () {
                      context.setLocale(Locale('en'));
                      isEn = true;
                    },
                    ontap2: () {
                      context.setLocale(Locale('ar'));
                      isEn = false;
                    },
                    isEn: isEn,
                  ),
                  CustomChoose(
                      ontap1: () {
                        if (provider.themeMode == ThemeMode.dark) {
                          provider.changeThemeMode();
                          isLight = true;
                        }
                      },
                      ontap2: () {
                        if (provider.themeMode == ThemeMode.light) {
                          provider.changeThemeMode();
                          isLight = false;
                        }
                      },
                      right: isLight,
                      title: "theme_theme".tr(),
                      item1: Icon(
                        Icons.wb_sunny_outlined,
                        color: isLight ? Colors.black : Colors.white,
                      ),
                      item2: Icon(
                        Icons.nightlight_rounded,
                        color: isLight ? Colors.black : Colors.white,
                      )),
                ],
              ),
              CustomButton(
                ontap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouts.onboarding);
                },
                color: AppColorsDark.primaryColor,
                widget: Text(
                  "theme_bottom".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
