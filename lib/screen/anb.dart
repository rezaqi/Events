import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/screen/favorite.dart';
import 'package:evently/screen/home.dart';
import 'package:evently/screen/map.dart';
import 'package:evently/screen/profile.dart';
import 'package:flutter/material.dart';

class ANB extends StatefulWidget {
  const ANB({super.key});

  @override
  State<ANB> createState() => _ANBState();
}

class _ANBState extends State<ANB> {
  int i = 0;

  final List<Widget> _pages = [
    Home(),
    Favorite(),
    MapPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRouts.addEvent);
          },
          child: Icon(
            Icons.add,
            color: AppColors.background,
            size: 30,
          ),
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(
              side: BorderSide(width: 3, color: AppColors.background)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: i,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.dark,
          unselectedFontSize: 12,
          onTap: (value) {
            print(i);

            i = value;
            setState(() {});
          },
          iconSize: 20,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'home'.tr(),
                backgroundColor: AppColors.primaryColor),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Icon(Icons.favorite),
                ),
                label: 'fav'.tr(),
                backgroundColor: AppColors.primaryColor),
            //BottomNavigationBarItem(icon: SizedBox(width: 40), label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Icon(Icons.location_on),
                ),
                label: 'map'.tr(),
                backgroundColor: AppColors.primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'profile'.tr(),
                backgroundColor: AppColors.primaryColor),
          ],
          backgroundColor: AppColors.primaryColor,
        ),
        body: _pages[i]);
  }
}
