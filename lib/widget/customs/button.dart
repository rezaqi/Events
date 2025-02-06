import 'package:evently/core/class/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Widget widget;
  final void Function()? ontap;
  const CustomButton({
    super.key,
    this.color,
    required this.widget,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: h / 15,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.primaryColor),
              color: color,
              borderRadius: BorderRadius.circular(16)),
          child: widget),
    );
  }
}
