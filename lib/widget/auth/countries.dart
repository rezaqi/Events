import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/widget/egypt.dart';
import 'package:flutter/material.dart';

class Countries extends StatelessWidget {
  final bool isEn;
  const Countries({super.key, required this.isEn});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      height: h / 30,
      width: w / 7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppColors.primaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.all(isEn ? 2.5 : 0),
              decoration: BoxDecoration(
                  color: isEn ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset(AppImages.en)),
          Container(
              padding: EdgeInsets.all(!isEn ? 2.5 : 0),
              decoration: BoxDecoration(
                  color: !isEn ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Egypt()),
        ],
      ),
    );
  }
}
