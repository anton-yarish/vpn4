import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Color buttonColor;
  double horizontalPadding;
  double verticalPadding;
  double buttonHeight;
  double buttonWidth;
  double buttonRadius;
  Widget child;

  MyButton({
    Key? key,
    this.buttonColor = const Color(0xff3B3B3B),
    this.buttonHeight = 60,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.buttonRadius = 11,
    this.buttonWidth = double.infinity,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Container(
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonRadius),
              color: buttonColor),
          child: Center(
            child: child,
          )),
    );
  }
}
