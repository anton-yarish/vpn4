import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimpleShadowContainer extends StatelessWidget {
  Color color;
  Color shadowColor;
  double horizontalPadding;
  double verticalPadding;
  double height;
  double width;
  double radius;
  Widget child;
  Alignment alignment;
  Offset offset;
  double blurRadius;
  double borderWidth;
  bool isBorder;
  Color borderColor;
  VoidCallback? onPress;
  EdgeInsetsGeometry? padding;
  SimpleShadowContainer(
      {Key? key,
      this.color = const Color(0xff3B3B3B),
      this.shadowColor = Colors.black,
      this.height = 54,
      this.horizontalPadding = 0,
      this.verticalPadding = 0,
      this.radius = 8,
      this.width = double.infinity,
      required this.child,
      this.alignment = Alignment.center,
      this.offset = const Offset(3, 3),
      this.isBorder = false,
      this.onPress,
      this.borderColor = const Color(0xff707070),
      this.borderWidth = 0.50,
      this.padding,
      this.blurRadius = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: GestureDetector(
        onTap: onPress ?? () {},
        child: Container(
            padding: padding ?? EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
                border: isBorder
                    ? Border.all(color: borderColor, width: borderWidth)
                    : null,
                boxShadow: [
                  BoxShadow(
                      offset: offset,
                      blurRadius: blurRadius,
                      color: shadowColor),
                ]),
            alignment: alignment,
            height: height,
            width: width,
            child: Align(alignment: alignment, child: child)),
      ),
    );
  }
}
