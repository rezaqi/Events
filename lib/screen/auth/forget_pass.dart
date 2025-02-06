import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/widget/customs/button.dart';
import 'package:flutter/material.dart';

class ForgetPass extends StatelessWidget {
  const ForgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forget_pass_page".tr()),
      ),
      body: Column(
        children: [
          Image.asset(AppImages.forgetPass),
          CustomButton(
              color: AppColors.primaryColor,
              widget: Text(
                "reset_password".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.white),
              ))
        ],
      ),
    );
  }
}
