import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final int minLines;
  final bool isPass;
  final bool isShow;
  final String title;
  final IconData? icon;
  final void Function()? ontap;
  final TextEditingController c;
  final String? Function(String?)? validat;
  const CustomTextForm({
    super.key,
    this.isPass = false,
    required this.title,
    this.isShow = true,
    this.ontap,
    required this.c,
    this.validat,
    required this.icon,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: isPass ? 1 : null,
      validator: validat,
      minLines: minLines,
      controller: c,
      obscureText: isPass ? !isShow : false,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColors.icon,
          ),
          label: Text(
            context.tr(title),
            style: TextStyle(color: AppColors.icon),
          ),
          suffixIcon: InkWell(
            onTap: ontap,
            child: isPass
                ? isShow
                    ? Icon(Icons.remove_red_eye, color: AppColors.icon)
                    : Icon(Icons.visibility_off, color: AppColors.icon)
                : SizedBox(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          )),
    );
  }
}
