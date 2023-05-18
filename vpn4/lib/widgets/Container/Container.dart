import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Color color, borderColor;
  final double horizontalPadding, verticalPadding, width, radius, borderWidth;
  final bool isBorder;
  final Widget child;
  final Alignment alignment;
  double? height;
  LinearGradient? linearGradient;
  final VoidCallback? onPressed;

  MyContainer(
      {Key? key,
      this.color = const Color(0xff3B3B3B),
      this.height,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.radius = 11,
      this.linearGradient,
      this.width = double.infinity,
      this.borderWidth = 1,
      this.isBorder = false,
      required this.child,
      this.onPressed,
      this.borderColor = Colors.white,
      this.alignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            gradient: linearGradient,
            border: Border.all(
                color: isBorder ? borderColor : Colors.white.withOpacity(0),
                width: borderWidth),
            borderRadius: BorderRadius.circular(radius)),
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              elevation: 0,
              backgroundColor: Colors.transparent,
              alignment: alignment,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              )),
          child: child,
        ),
      ),
    );
  }
}
