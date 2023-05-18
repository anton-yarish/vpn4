import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tag_vpn/Utils/Colors.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color? fontColor;
  double? wordSpacing, letterSpacing;
  TextAlign textAlignment;
  bool textOverflow;
  double height;
  TextDecoration textDecoration;
  MyText(
      {Key? key,
      required this.text,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.fontColor,
      this.textOverflow = false,
      this.textAlignment = TextAlign.start,
      this.height = 1.2,
      this.letterSpacing,
      this.wordSpacing,
      this.textDecoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow ? TextOverflow.ellipsis : null,
      textAlign: textAlignment,
      style: GoogleFonts.poppins(
          color: fontColor ?? Colors.white,
          fontSize: fontSize,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
          height: height,
          decoration: textDecoration),
    );
  }
}
