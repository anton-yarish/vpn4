import 'package:flutter/material.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/widgets/text.dart';

ElevatedButton customButton({
  required String text,
  required VoidCallback onPressed,
  double? width = 240.0,
  double? height = 46.0,
  double? borderRadius = 10.0,
  double? fontSize = 14.0,
  FontWeight? fontWeight = FontWeight.w600,
  Color? foregroundColor = Colors.black,
  Color? backgroundColor = Palette.appColor,
  Color? borderColor = Palette.appColor,
  Alignment? alignment = Alignment.center,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: buttonStyle(borderRadius, width, height, fontWeight, fontSize,
        foregroundColor, backgroundColor, borderColor, alignment),
    child: MyText(
      text: text,
      fontWeight: FontWeight.w400,
      fontColor: Colors.black,
    ),
  );
}

ElevatedButton customIconButton({
  required Widget leading,
  required VoidCallback onPressed,
  required Widget trailing,
  double? width = 240.0,
  double? height = 40.0,
  double? borderRadius = 10.0,
  double? fontSize = 14.0,
  FontWeight? fontWeight = FontWeight.w500,
  Color? foregroundColor = Colors.black,
  Color? backgroundColor = Palette.appColor,
  Color? borderColor = Palette.appColor,
  Alignment? alignment = Alignment.center,
}) {
  return ElevatedButton.icon(
    icon: leading,
    onPressed: onPressed,
    style: buttonStyle(borderRadius, width, height, fontWeight, fontSize,
        foregroundColor, backgroundColor, borderColor, alignment),
    label: trailing,
  );
}

ButtonStyle buttonStyle(
  double? borderRadius,
  double? width,
  double? height,
  FontWeight? fontWeight,
  double? fontSize,
  Color? foregroundColor,
  Color? backgroundColor,
  Color? borderColor,
  Alignment? alignment,
) {
  return ButtonStyle(
      alignment: alignment,
      side: MaterialStateProperty.resolveWith(
          (states) => BorderSide(color: borderColor!, width: 1.5)),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => backgroundColor),
      foregroundColor:
          MaterialStateProperty.resolveWith((states) => foregroundColor),
      textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
          fontSize: fontSize, fontFamily: "", fontWeight: fontWeight)),
      shape: MaterialStateProperty.resolveWith(
        (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!)),
      ),
      fixedSize:
          MaterialStateProperty.resolveWith((states) => Size(width!, height!)));
}
