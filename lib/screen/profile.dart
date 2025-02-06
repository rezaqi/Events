import 'package:easy_localization/easy_localization.dart';
import 'package:evently/provider/provider.dart';
import 'package:evently/widget/profile/appbar.dart';
import 'package:evently/widget/profile/custom_setting.dart';
import 'package:evently/widget/profile/logout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarProfile(),
              SizedBox(
                height: 20,
              ),
              CustomSetting(
                ontap1: () {
                  context.setLocale(Locale('en'));
                },
                ontap2: () {
                  context.setLocale(Locale('ar'));
                },
                title: "Language",
                titleText: "English",
                text1: "language_en".tr(),
                text2: "language_ar".tr(),
              ),
              CustomSetting(
                ontap1: () {
                  provider.changeThemeModeToDark();
                },
                ontap2: () {
                  provider.changeThemeModeToLight();
                },
                title: "Theme",
                titleText: "Light",
                text1: "Dark",
                text2: "Light",
              ),
            ],
          ),
          LogOut()
        ],
      ),
    );
  }
}
