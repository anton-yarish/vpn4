import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:tag_vpn/Utils/Colors.dart';

class GradientBG extends StatelessWidget {
  const GradientBG({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColors.blueGradient1,
            MyColors.blueGradient2,
          ],
        ),
      ),
      child: child,
    );
  }
}
