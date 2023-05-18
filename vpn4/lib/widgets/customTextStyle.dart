import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class freeSansText extends StatelessWidget {
  String text;
  Color color;
  double fontSize;
  freeSansText(
      {super.key,
      required this.text,
      this.color = Colors.white,
      this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "FreeSans",
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: fontSize),
    );
  }
}
