import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/text_app.dart';
import 'package:evently/core/static/category.dart';
import 'package:evently/provider/provider.dart';
import 'package:evently/widget/home/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  int i = 0;
  int res = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return FutureBuilder(
        future: provider.users.doc(provider.userId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              padding: EdgeInsets.all(15),
              height: 200,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  color: provider.themeMode == ThemeMode.light
                      ? AppColors.primaryColor
                      : AppColorsDark.background),
              child: SafeArea(
                child: snapshot.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator()
                    : Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "welcome_back".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.white),
                                  ),
                                  Text(
                                    !snapshot.hasData ||
                                            snapshot.data?.data() == null
                                        ? AppText.sir
                                        : "${snapshot.data!["name"] ?? AppText.sir}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            fontSize: 24,
                                            color: AppColors.white),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 5,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      provider.changeThemeMode();
                                    },
                                    child: provider.themeMode == ThemeMode.light
                                        ? Icon(
                                            Icons.sunny,
                                            color: AppColors.white,
                                          )
                                        : Icon(
                                            Icons.dark_mode,
                                            color: AppColors.white,
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.changeLanguage(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(AppText.en.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: provider.themeMode ==
                                                          ThemeMode.light
                                                      ? AppColors.primaryColor
                                                      : AppColorsDark
                                                          .background)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.white,
                              ),
                              Text(
                                "cairo_egypt".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.white),
                              )
                            ],
                          ),
                          SizedBox(
                              height: 40,
                              child: Expanded(
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: 10,
                                          ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: event.length,
                                      itemBuilder: (context, index) => SizedBox(
                                            height: 10,
                                            width: 150,
                                            child: InkWell(
                                              onTap: () {
                                                res = selected(i, index);
                                                changeI.i = res;
                                                provider.changeIi();
                                              },
                                              child: CustomCategories(
                                                borderColor: provider
                                                            .themeMode ==
                                                        ThemeMode.light
                                                    ? AppColors.background
                                                    : AppColors.primaryColor,
                                                textColor: res == index
                                                    ? provider.themeMode ==
                                                            ThemeMode.light
                                                        ? AppColors.primaryColor
                                                        : AppColors.white
                                                    : AppColors.background,
                                                backgroundColor: res == index
                                                    ? provider.themeMode ==
                                                            ThemeMode.light
                                                        ? AppColors.background
                                                        : AppColors.primaryColor
                                                    : provider.themeMode ==
                                                            ThemeMode.light
                                                        ? AppColors.primaryColor
                                                        : AppColorsDark
                                                            .background,
                                                icon: event[index]["icon"],
                                                title: context.locale ==
                                                        Locale("en")
                                                    ? event[index]["name"]
                                                    : event[index]["name_ar"],
                                                i: res == index ? true : false,
                                              ),
                                            ),
                                          )))),
                        ],
                      ),
              ),
            );
          }
          return SizedBox();
        });
  }
}

int selected(int sel, int indexT) {
  sel = indexT;
  return sel;
}

abstract class changeI {
  static int i = 0;
}
