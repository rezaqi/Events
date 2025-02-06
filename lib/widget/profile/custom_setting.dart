import 'package:evently/core/class/colors.dart';
import 'package:flutter/material.dart';

class CustomSetting extends StatefulWidget {
  final String text1;
  final String text2;
  final String titleText;
  final String title;
  final Function()? ontap1;
  final Function()? ontap2;

  const CustomSetting({
    super.key,
    required this.text1,
    required this.text2,
    required this.titleText,
    required this.title,
    this.ontap1,
    this.ontap2,
  });

  @override
  State<CustomSetting> createState() => _CustomSettingState();
}

class _CustomSettingState extends State<CustomSetting> {
  bool i = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.dark),
          ),
          InkWell(
            onTap: () {
              i = !i;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: i ? 100 : 50,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: AppColors.primaryColor,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  i
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: widget.ontap1,
                              child: Text(widget.text1,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            InkWell(
                              onTap: widget.ontap2,
                              child: Text(widget.text2,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            )
                          ],
                        )
                      : Text(widget.titleText,
                          style: Theme.of(context).textTheme.titleLarge),
                  i
                      ? Icon(
                          Icons.arrow_left_rounded,
                          color: AppColors.primaryColor,
                          size: 30,
                        )
                      : Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.primaryColor,
                          size: 30,
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
