import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseManager.logout();
        Navigator.popAndPushNamed(context, AppRouts.login);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(15)),
        child: Row(
          spacing: 10,
          children: [
            Icon(
              Icons.logout_rounded,
              color: AppColors.white,
            ),
            Text(
              "pro_log_out".tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
