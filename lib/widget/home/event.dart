import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/core/static/category.dart';
import 'package:evently/data/model/event_model.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:evently/provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomEvent extends StatelessWidget {
  final EventModel eventModel;

  const CustomEvent({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(0.5),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: provider.themeMode == ThemeMode.light
              ? AppColors.primaryColor
              : AppColorsDark.background,
        ),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryColor,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              width: double.infinity,
              height: double.infinity,
              "${event[eventModel.image]["image"]}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: 60,
            width: 50,
            decoration: BoxDecoration(
                color: provider.themeMode == ThemeMode.light
                    ? AppColors.background
                    : AppColorsDark.background,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${DateTime.fromMicrosecondsSinceEpoch(eventModel.date).toString().substring(8, 10)}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "${millisecondToMonth(eventModel.date)}",
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              // width: 250,
              decoration: BoxDecoration(
                  color: provider.themeMode == ThemeMode.light
                      ? AppColors.background
                      : AppColorsDark.background,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " ${eventModel.title}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: provider.themeMode == ThemeMode.light
                              ? AppColors.dark
                              : AppColorsDark.icon,
                        ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            FirebaseManager.addFavEvent(EventModel(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                title: eventModel.title,
                                image: eventModel.image,
                                description: eventModel.description,
                                date: eventModel.date,
                                timer: eventModel.timer,
                                category: eventModel.category,
                                location: eventModel.location));
                          },
                          child: Icon(Icons.favorite,
                              color: AppColors.primaryColor)),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouts.editEvent,
                              arguments: eventModel);
                        },
                        child: Icon(Icons.edit),
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseManager.deleteEvent(eventModel.id);
                        },
                        child: Icon(Icons.delete),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String millisecondToMonth(int millisecond) {
  DateTime date = DateTime.fromMicrosecondsSinceEpoch(millisecond);
  return DateFormat("MMM").format(date);
}
