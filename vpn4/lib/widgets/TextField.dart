import 'package:flutter/material.dart';
import 'package:tag_vpn/constants/colors.dart';

import '../Utils/Colors.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  bool isObscure;
  bool obscureIcon;
  final TextInputAction? textInputAction;

  MyTextField(
      {super.key,
      this.textInputAction,
      this.controller,
      this.hintText,
      this.obscureIcon = false,
      this.isObscure = false});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      obscureText: widget.isObscure,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.obscureIcon
            ? InkWell(
                onTap: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                  });
                },
                child: Icon(
                  widget.isObscure
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Palette.appColor,
                ),
              )
            : null,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Color(0xff020D43),
        hintText: widget.hintText ?? "Example@gmail.com",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 1)),
      ),
    );
  }
}
