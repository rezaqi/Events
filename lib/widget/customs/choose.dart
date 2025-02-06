import 'package:evently/core/class/colors.dart';
import 'package:flutter/material.dart';

class CustomChoose extends StatefulWidget {
  final String? title;
  final Widget item1;
  final Widget item2;
  final bool right;
  final void Function()? ontap1;

  final void Function()? ontap2;

  const CustomChoose(
      {super.key,
      this.title,
      required this.item1,
      required this.item2,
      required this.right,
      required this.ontap1,
      this.ontap2});

  @override
  State<CustomChoose> createState() => _CustomChooseState();
}

class _CustomChooseState extends State<CustomChoose> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(
          height: h / 25,
          width: w / 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: AppColors.primaryColor)),
          child: Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: widget.ontap1,
                  child: Container(
                      height: h / 25,
                      width: 30,
                      padding:
                          widget.right ? EdgeInsets.all(5) : EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: widget.right
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: widget.item1),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: widget.ontap2,
                  child: Container(
                      height: h / 20,
                      padding:
                          widget.right ? EdgeInsets.all(2) : EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: widget.right
                            ? Colors.transparent
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Expanded(child: widget.item2)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
