import 'package:evently/core/class/colors.dart';
import 'package:flutter/material.dart';

customShowDialog(
    BuildContext context, String title, void Function()? ontap, Widget widget) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        spacing: 10,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          InkWell(
              onTap: ontap,
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(width: 1, color: AppColors.primaryColor)),
                  child: widget
                  // Text(
                  //   subTitle,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .copyWith(color: AppColors.primaryColor),
                  // ),
                  )),
        ],
      ),
    ),
  );
}
