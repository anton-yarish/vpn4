import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_vpn/Screens/forgetpassscreen/OtpScreen.dart';
import 'package:tag_vpn/Screens/homescreen/homescreen.dart';
import 'package:tag_vpn/Screens/loginscreen/login.dart';
import 'package:tag_vpn/ViewModel/UserVModel.dart';
import '../LocalData/PrefManager.dart';
import '../Repositories/AuthRepository.dart';
import '../Utils/Colors.dart';
import '../Utils/Utils.dart';
import '../widgets/SubmitButton.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  Future<dynamic> login(BuildContext context, dynamic data) async {
    Utils.hideKeyboard();
    setLoading(true);
    _myRepo.login(data).then((value) async {
      if (value["success"] == true) {
        await PrefManager().saveUser(value).then((value) async {
          setLoading(false);
          await UserVModel().checkUser();
          Utils.navigate(page: HomeScreen());
        });
      } else if (value["success"] == false) {
        Utils.snackBarDefaultMessage(
            context: context, message: value["message"]);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.snackBarDefaultMessage(context: context, message: error.toString());
    });
  }

  Future<dynamic> register(BuildContext context, dynamic data) async {
    Utils.hideKeyboard();
    setLoading(true);
    _myRepo.register(data).then((value) async {
      if (value["success"] == true) {
        setLoading(false);
        Utils.snackBarDefaultMessage(
            context: context, message: value["message"]);
        if (value["Data"]["is_verified"] == "0") {
          Future.delayed(const Duration(milliseconds: 1000)).then((value) {
            Utils.snackBarDefaultMessage(
                context: context,
                message:
                    "Please wait for approval from admin. You will be notified soon.");
            Get.back();
          });
        } else {
          await PrefManager().saveUser(value).then((value) async {
            await UserVModel().checkUser();
            Utils.navigate(page: HomeScreen());
          });
        }
      } else if (value["success"] == false) {
        Utils.snackBarDefaultMessage(
            context: context, message: value["message"]);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.snackBarDefaultMessage(context: context, message: error.toString());
    });
  }

  Future<dynamic> forgetPass(BuildContext context, dynamic data) async {
    Utils.hideKeyboard();
    setLoading(true);
    _myRepo.forgetPass(data).then((value) async {
      print(value);
      if (value["success"] == true) {
        setLoading(false);
        Utils.navigate(
            page: OtpScreen(
          email: data["email"],
          otp: value["Data"].toString(),
        ));
      } else if (value["success"] == false) {
        Utils.snackBarDefaultMessage(
            context: context, message: value["errorMessage"].toString());
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.snackBarDefaultMessage(context: context, message: error.toString());
    });
  }

  Future<dynamic> changePass(BuildContext context, dynamic data) async {
    Utils.hideKeyboard();
    setLoading(true);
    _myRepo.changePass(data).then((value) async {
      print(value);
      if (value["success"] == true) {
        setLoading(false);
        Utils.snackBarDefaultMessage(
            context: context, message: value["message"]);
        Utils.navigate(page: HomeScreen());
      } else if (value["success"] == false) {
        Utils.snackBarDefaultMessage(
            context: context, message: value["errorMessage"].toString());
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.snackBarDefaultMessage(context: context, message: error.toString());
    });
  }
}
