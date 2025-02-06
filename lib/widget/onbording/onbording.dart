import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomOnboarding extends StatelessWidget {
  String title;
  String des;
  String image;
  CustomOnboarding(
      {super.key, required this.title, required this.des, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        spacing: 10,
        children: [
          Align(alignment: Alignment.center, child: Image.asset(image)),
          Text(
            context.tr(title),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            des.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
