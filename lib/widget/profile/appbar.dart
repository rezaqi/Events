import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return FutureBuilder(
      future: provider.users.doc(provider.userId).get(),
      builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(20),
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: context.locale == Locale("ar")
                            ? Radius.circular(0)
                            : Radius.circular(100),
                        bottomRight: context.locale == Locale("en")
                            ? Radius.circular(0)
                            : Radius.circular(100),
                      )),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              alignment: Alignment.center,
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: context.locale == Locale("ar")
                                        ? Radius.circular(80)
                                        : Radius.circular(0),
                                    bottomRight: Radius.circular(80),
                                    bottomLeft: Radius.circular(80),
                                    topRight: context.locale == Locale("en")
                                        ? Radius.circular(80)
                                        : Radius.circular(0),
                                  )),
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("choose_a_picture".tr())),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                !snapshot.hasData ||
                                        snapshot.data?.data() == null
                                    ? "Sir"
                                    : "${snapshot.data!["name"] ?? "Sir"}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.background)),
                            Text(
                                !snapshot.hasData ||
                                        snapshot.data?.data() == null
                                    ? ""
                                    : "${snapshot.data!["email"] ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.background))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
