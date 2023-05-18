import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Model/LanguageModel.dart';
import 'package:tag_vpn/ViewModel/AuthModel.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';
import 'package:tag_vpn/ViewModel/PurchaseModel.dart';
import 'package:tag_vpn/ViewModel/UserVModel.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/Screens/splashscreen/splashscreen.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'ViewModel/LocaleModel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MainViewModel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => UserVModel()),
    ],
    child: MyApp(),
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              actionsIconTheme: IconThemeData(color: blackColour),
              toolbarHeight: 80,
              iconTheme: const IconThemeData(size: 32, color: Colors.black),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(0), left: Radius.circular(0)))),
          primarySwatch: Palette.appColor,
        ),
        home: const SplashScreen());
  }
}
