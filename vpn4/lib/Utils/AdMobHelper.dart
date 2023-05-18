// import 'dart:io';

// import 'package:tag_vpn/LocalData/PrefManager.dart';
// import 'package:tag_vpn/Model/AdModel.dart';

// class AdHelper {
//   static String androidBannerAdUnit = "ca-app-pub-3940256099942544/6300978111";
//   static String iosBannerAdUnit = "ca-app-pub-3940256099942544/2934735716";
//   static String androidInterAdUnit = "ca-app-pub-3940256099942544/1033173712";
//   static String iosInterAdUnit = "ca-app-pub-3940256099942544/4411468910";
//   static String androidRewardedAdUnit =
//       "ca-app-pub-3940256099942544/5224354917";
//   static String iosRewardedAdUnit = "ca-app-pub-3940256099942544/1712485313";
//   static String androidAppID = "ca-app-pub-3940256099942544~3347511713";
//   static String iosAppID = "ca-app-pub-3940256099942544~3347511713";

//   static String get appId {
//     if (Platform.isAndroid) {
//       return androidAppID;
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-3940256099942544~1458002511';
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   static String get bannerAdUnitId {
//     if (Platform.isAndroid) {
//       return androidBannerAdUnit;
//     } else if (Platform.isIOS) {
//       return iosBannerAdUnit;
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }

//   static String get interstitialAdUnitId {
//     if (Platform.isAndroid) {
//       return androidInterAdUnit;
//     } else if (Platform.isIOS) {
//       return iosInterAdUnit;
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get rewardedAdUnitId {
//     if (Platform.isAndroid) {
//       return androidRewardedAdUnit;
//     } else if (Platform.isIOS) {
//       return iosRewardedAdUnit;
//     } else {
//       throw UnsupportedError("Unsupported platform");
//     }
//   }
// }
