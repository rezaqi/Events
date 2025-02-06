import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/widget/onbording/dout.dart';
import 'package:evently/widget/onbording/onbording.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int ontapSkip = 0;
  int i = 0;
  String? iconIsEn;
  @override
  void initState() {
    iconIsEn = "icon".tr();
    print(iconIsEn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Icon icon = iconIsEn == "ar"
        ? Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: AppColors.primaryColor,
          )
        : Icon(
            Icons.arrow_circle_right_outlined,
            size: 40,
            color: AppColors.primaryColor,
          );
    PageController? c = PageController(
      initialPage: i,
    );
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(AppImages.title),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    i = value;
                    if (i == 2) {}
                    setState(() {});
                  },
                  controller: c,
                  children: [
                    CustomOnboarding(
                        image: AppImages.onBording1,
                        title: "onboarding1_title",
                        des: "onboarding1_description"),
                    CustomOnboarding(
                        image: AppImages.onbording2,
                        title: "onboarding2_title",
                        des: "onboarding2_description"),
                    CustomOnboarding(
                        image: AppImages.onbording3,
                        title: "onboarding3_title",
                        des: "onboarding3_description")
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    spacing: 6,
                    children: [
                      Dot(iPage: i, iDot: 0),
                      Dot(iPage: i, iDot: 1),
                      Dot(iPage: i, iDot: 2)
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        if (ontapSkip == 0) {
                          c.animateToPage(2,
                              duration: Duration(seconds: 1),
                              curve: Curves.decelerate);
                          ontapSkip++;
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRouts.login);
                        }

                        setState(() {});
                      },
                      child: icon)
                ],
              )
            ],
          ),
        ));
  }
}
