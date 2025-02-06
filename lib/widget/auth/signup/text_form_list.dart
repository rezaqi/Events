import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/func/email.dart';
import 'package:evently/widget/customs/text_form.dart';
import 'package:flutter/material.dart';

class TextFormList extends StatefulWidget {
  final GlobalKey<FormState> formState;

  final TextEditingController? cEmail;
  final TextEditingController? cPass;
  final TextEditingController? cName;
  final TextEditingController? cRPass;
  const TextFormList(
      {super.key,
      required this.formState,
      required this.cEmail,
      required this.cPass,
      required this.cName,
      required this.cRPass});

  @override
  State<TextFormList> createState() => _TextFormListState();
}

class _TextFormListState extends State<TextFormList> {
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
            icon: Icons.person,
            validat: (val) {
              if (val == null || val.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
            c: widget.cName!,
            ontap: () {},
            isShow: true,
            isPass: false,
            title: "name".tr(),
          ),
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
              validat: (val) {
                if (val == null || val.isEmpty) {
                  return 'password is required';
                } else if (val.length > 30) {
                  return 'Password must be less than 30 characters';
                } else if (val.length < 8) {
                  return 'Password must be more than 8 characters';
                } else if (widget.cPass!.text != widget.cRPass!.text) {
                  return 'your passwords is not the same';
                }
                return null;
              },
              icon: Icons.lock,
              c: widget.cPass!,
              ontap: () {
                isShow ? isShow = false : isShow = true;
                setState(() {});
              },
              isShow: isShow,
              isPass: true,
              title: "pass".tr()),
          CustomTextForm(
              minLines: 1,
              validat: (val) {
                if (val == null || val.isEmpty) {
                  return 'password is required';
                } else if (val.length > 30) {
                  return 'Password must be less than 30 characters';
                } else if (val.length < 8) {
                  return 'Password must be more than 8 characters';
                } else if (widget.cPass!.text != widget.cRPass!.text) {
                  return 'your passwords is not the same';
                }
                return null;
              },
              icon: Icons.lock,
              c: widget.cRPass!,
              ontap: () {
                isShow ? isShow = false : isShow = true;
                setState(() {});
              },
              isShow: isShow,
              isPass: true,
              title: "r_pass".tr()),
        ],
      ),
    );
  }
}
