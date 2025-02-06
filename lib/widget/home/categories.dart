import 'package:flutter/material.dart';

class CustomCategories extends StatelessWidget {
  final IconData? icon;
  final String title;
  final bool i;
  bool isAll;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  CustomCategories({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.icon,
    required this.title,
    required this.i,
    this.isAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: isAll ? 84 : 100,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
