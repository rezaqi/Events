import 'package:flutter/material.dart';

class Dot extends StatefulWidget {
  final int iDot;
  final int iPage;
  const Dot({super.key, required this.iPage, required this.iDot});

  @override
  State<Dot> createState() => _DotState();
}

class _DotState extends State<Dot> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      width: widget.iDot == widget.iPage ? 21 : 8,
      height: 8,
      decoration: BoxDecoration(
          color: widget.iDot == widget.iPage ? Colors.blue : Colors.black,
          borderRadius: BorderRadius.circular(36)),
    );
  }
}
