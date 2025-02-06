import 'package:flutter/material.dart';

class CustomAddTime extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function()? ontap;
  const CustomAddTime(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(icon),
        Text(title),
        Spacer(),
        InkWell(onTap: ontap, child: Text(subtitle))
      ],
    );
  }
}
