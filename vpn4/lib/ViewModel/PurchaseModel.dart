// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:purchases_flutter/object_wrappers.dart';

// class PurchaseModel extends ChangeNotifier {
//   static const _googleApiKey = "goog_hMSefcxFVIYWuSKMqIezIvJBchO";
//   static const _appleApiKey = "";
//   static var availablePackages;

//   // static Future<void> init() async {
//   //   await Purchases.setDebugLogsEnabled(true);
//   //   PurchasesConfiguration? configuration;

//   //   if (Platform.isAndroid) {
//   //     configuration = PurchasesConfiguration(_googleApiKey);
//   //   } else if (Platform.isIOS) {
//   //     configuration = PurchasesConfiguration(_appleApiKey);
//   //   }
//   //   await Purchases.configure(configuration!);
//   // }

//   // static Future<void> fetchOffers() async {
//   //   try {
//   //     final offerings = await Purchases.getOfferings();
//   //     availablePackages = offerings.current?.availablePackages;
//   //     // final subscription = [current];
//   //     // packages = subscription
//   //     //     .map((offer) => offer!.availablePackages)
//   //     //     .expand((pair) => pair)
//   //     //     .toList();
//   //   } catch (e) {
//   //     if (kDebugMode) {
//   //       print(e);
//   //     }
//   //   }
//   // }

//   static Future<void> purchase(int index) async {
//     try {
//       await Purchases.purchasePackage(availablePackages![index]!).then((value) {
//         print("this is $value");
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }
// }
