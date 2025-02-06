import 'package:evently/core/class/images.dart';
import 'package:flutter/material.dart';

class ThemePageImage extends StatelessWidget {
  const ThemePageImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.pageTheme,
        fit: BoxFit.cover,
      ),
    );
  }
}
