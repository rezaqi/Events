import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/core/func/email.dart';
import 'package:evently/widget/customs/text_form.dart';
import 'package:flutter/material.dart';

class BothTextForm extends StatefulWidget {
  final GlobalKey<FormState> formState;
  final TextEditingController? cEmail;
  final TextEditingController? cPass;

  const BothTextForm(
      {super.key, required this.formState, this.cEmail, this.cPass});

  @override
  State<BothTextForm> createState() => _BothTextFormState();
}

class _BothTextFormState extends State<BothTextForm> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          CustomTextForm(
            minLines: 1,
            icon: Icons.email,
            validat: (val) {
              if (val == null || val.isEmpty) {
                return 'Email is required';
              } else if (!val.isValidEmail()) {
                return 'Invalid Email';
              }
              return null;
            },
            c: widget.cEmail!,
            ontap: () {},
            isShow: true,
            isPass: false,
            title: "email".tr(),
          ),
          CustomTextForm(
              minLines: 1,
              icon: Icons.lock,
              validat: (val) {
                if (val == null || val.isEmpty) {
                  return 'password is required';
                } else if (val.length > 30) {
                  return 'Password must be less than 30 characters';
                } else if (val.length < 8) {
                  return 'Password must be more than 8 characters';
                }
                return null;
              },
              c: widget.cPass!,
              ontap: () {
                isShow ? isShow = false : isShow = true;
                setState(() {});
              },
              isShow: isShow,
              isPass: true,
              title: "pass".tr()),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRouts.forgtPass);
            },
            child: Text(
              "forget_pass".tr(),
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                  decorationColor: AppColors.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  textBaseline: TextBaseline.ideographic),
            ),
          )
        ],
      ),
    );
  }
}
