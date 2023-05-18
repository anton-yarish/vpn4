import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tag_vpn/constants/colors.dart';

Widget roundedTextbox({
  required String hinttext,
  required BuildContext context,
  TextEditingController? textdata,
  double? height = 44,
  IconData? icon,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    height: height,
    child: TextField(
        inputFormatters: inputFormatters,
        controller: textdata,
        style: TextStyle(color: blackColour),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
          ),
          hintText: hinttext,
        )),
  );
}
