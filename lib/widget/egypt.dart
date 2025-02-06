import 'package:evently/core/class/images.dart';
import 'package:flutter/material.dart';

class Egypt extends StatelessWidget {
  const Egypt({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 21,
      width: 21,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Image.asset(AppImages.flagLogo),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
