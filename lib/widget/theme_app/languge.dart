import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/widget/customs/choose.dart';
import 'package:evently/widget/egypt.dart';
import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  final void Function()? ontap1;
  final void Function()? ontap2;
  final bool isEn;
  const Language({super.key, required this.isEn, this.ontap1, this.ontap2});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return CustomChoose(
        ontap1: widget.ontap1,
        ontap2: widget.ontap2,
        right: widget.isEn,
        title: "theme_language".tr(),
        item1: Image.asset(
          AppImages.en,
          fit: BoxFit.cover,
        ),
        item2: Egypt());
  }
}
