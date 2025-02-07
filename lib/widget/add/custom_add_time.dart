import 'package:flutter/material.dart';

class CustomAddTime extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function()? ontap;
  final Color? color;
  const CustomAddTime(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.ontap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Text(title, style: TextStyle(color: color)),
        Spacer(),
        InkWell(
            onTap: ontap, child: Text(subtitle, style: TextStyle(color: color)))
      ],
    );
  }
}
