import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_vpn/LocalData/PrefManager.dart';
import 'package:tag_vpn/Repositories/AuthRepository.dart';
import 'package:tag_vpn/Screens/homescreen/widgets/ServersList.dart';
import 'package:tag_vpn/Screens/loginscreen/login.dart';
import 'package:tag_vpn/Screens/privacyscreen/privacyscreen.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';
import 'package:tag_vpn/ViewModel/UserVModel.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/Screens/homescreen/homescreen.dart';
import 'package:tag_vpn/Screens/onboardingscreen/onboardingscreen.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isFirstTime;
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  final _myRepo = AuthRepository();
  _navigate() async {
    isFirstTime = await PrefManager.isFirstTime();
    isLoggedIn = await PrefManager().checkLogin();
    var userData = await PrefManager().readUser();

    await MainViewModel().getServers();
    var userLoginData = {
      "email": userData?.data?.email ?? "",
      "password": userData?.data?.password ?? "",
    };
    _myRepo.login(userLoginData).then((value) async {
      if (value == null) {
        Utils.navigate(page: const LoginScreen());
      } else {
        if (value["success"] == true) {
          await PrefManager().saveUser(value).then((value) async {
            await UserVModel().checkUser();
            Utils.navigate(page: HomeScreen());
          });
        } else if (value["success"] == false) {
          Utils.snackBarDefaultMessage(
              context: context, message: value["message"]);
          Utils.navigate(page: const LoginScreen());
        }
      }
    }).onError((error, stackTrace) {
      // Utils.snackBarDefaultMessage(context: context, message: error.toString());
      Utils.navigate(page: const LoginScreen());
    });

    /*   if (await Utils.CheckUserConnection()) {
      await MainViewModel().getServers();
      Utils.navigateAndRemoveA(
          page: isFirstTime!
              ? const PrivacyScreen()
              : isLoggedIn!
                  ? HomeScreen()
                  : const LoginScreen());
    } */
  }

  @override
  Widget build(BuildContext context) {
    return GradientBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
              width: 140,
              height: 140,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  fit: BoxFit.scaleDown,
                ),
              )),
        ),
      ),
    );
  }
}
