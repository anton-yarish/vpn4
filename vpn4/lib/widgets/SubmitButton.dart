import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'text.dart';

class SubmitButton extends StatelessWidget {
  Color? buttonColor;
  double horizontalPadding;
  double verticalPadding;
  double buttonHeight;
  double buttonWidth;
  double buttonRadius;
  VoidCallback onPress;
  String? text;
  bool isLoading;
  double fontSize;
  FontWeight fontWeight;
  Color fontColor;
  SubmitButton(
      {Key? key,
      this.buttonColor,
      this.buttonHeight = 46,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.buttonRadius = 10,
      this.buttonWidth = double.infinity,
      required this.onPress,
      this.text,
      this.isLoading = false,
      this.fontSize = 20,
      this.fontWeight = FontWeight.w500,
      this.fontColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor ?? Palette.appColor,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                )),
            child: Center(
              child: isLoading
                  ? const CupertinoActivityIndicator(
                      color: Colors.black,
                    )
                  : MyText(
                      text: text ?? "CONTINUE",
                      fontColor: fontColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
            )),
      ),
    );
  }
}
