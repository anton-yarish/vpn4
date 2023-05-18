import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:tag_vpn/widgets/Container/Container.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/text.dart';
import 'Colors.dart';

class Utils {
  static verticalSpacer(double height) {
    return SizedBox(
      height: height,
    );
  }

  static horizontalSpacer(double width) {
    return SizedBox(
      width: width,
    );
  }

  static snackBarErrorMessage(
      {required BuildContext context,
      required String message,
      Color color = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: MyText(
      text: message,
      fontColor: color,
    )));
  }

  static snackBarDefaultMessage(
      {required BuildContext context,
      required String message,
      Color color = Colors.white}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: MyText(
      text: message,
      fontColor: color,
    )));
  }

  static copyText(dynamic value) async {
    await Clipboard.setData(ClipboardData(text: value.toString()));
  }

  static Future<String> pasteText() async {
    ClipboardData? clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboard?.text.toString() ?? "";
  }

  static Future navigate(
      {required Widget page,
      Transition? transition,
      Duration? duration}) async {
    await Get.to(page,
        transition: transition ?? Transition.rightToLeft,
        duration: duration ?? const Duration(milliseconds: 350));
  }

  static Future navigateandRemove(
      {required Widget page,
      Transition? transition,
      Duration? duration}) async {
    await Get.off(page,
        transition: transition ?? Transition.rightToLeft,
        duration: duration ?? const Duration(milliseconds: 500));
  }

  static Future navigateAndRemoveA(
      {required Widget page,
      Transition? transition,
      Duration? duration}) async {
    await Get.offAll(page,
        transition: transition ?? Transition.rightToLeft,
        duration: duration ?? const Duration(milliseconds: 500));
  }

  static showCustomDialog(BuildContext context,
      {bool positiveButton = false,
      String positiveText = "Order now",
      VoidCallback? onPositiveClicked,
      String? title,
      String? description}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(33.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            var width = double.infinity;
            var height = MediaQuery.of(context).size.height;

            return IntrinsicHeight(
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Color(0xffBCBCBC),
                      size: 50,
                    ),
                    Utils.verticalSpacer(19),
                    MyText(
                      textAlignment: TextAlign.center,
                      text: title ?? "Currently unavailable",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontColor: MyColors.accentBlackColor,
                    ),
                    Utils.verticalSpacer(8),
                    MyText(
                      textAlignment: TextAlign.center,
                      text: description ??
                          "This feature is under construction until further notice",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontColor: MyColors.accentBlackColor,
                    ),
                    Utils.verticalSpacer(30),
                    MyContainer(
                        radius: 23,
                        height: 46,
                        color: MyColors.mainAccentColor,
                        child: MyText(
                            text: positiveButton ? positiveText : "Close",
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        onPressed: positiveButton
                            ? onPositiveClicked ?? () {}
                            : () {
                                Get.back();
                              }),
                    Utils.verticalSpacer(20),
                    positiveButton
                        ? InkWell(
                            onTap: () => Get.back(),
                            child: MyText(
                              text: "Close",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.black,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Future launchWebUrlExternal(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  static hideKeyboard() {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      // ignore: empty_catches
    } catch (e) {}
  }

  // ignore: non_constant_identifier_names
  static Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
