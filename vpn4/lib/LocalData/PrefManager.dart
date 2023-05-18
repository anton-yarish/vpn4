import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tag_vpn/Model/AdModel.dart';

import '../Model/UserModel.dart';

class PrefManager {
  late SharedPreferences sp;

  init() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future<bool> saveListConnectedIndex(var val) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(Pref.listIndex, jsonEncode(val));
  }

  Future<bool> saveUser(dynamic data) async {
    await init();
    UserModel userModel = UserModel.fromJson(data);
    sp.setString(Pref.userDataKey, json.encode(userModel));
    return sp.setBool(Pref.isLoggedIN, true);
  }

  Future<bool> saveAds(dynamic data) async {
    await init();
    AdModel adModel = AdModel.fromJson(data);
    return sp.setString(Pref.adsDataKey, json.encode(adModel));
  }

  Future<UserModel?> readUser() async {
    await init();
    String user = sp.getString(Pref.userDataKey) ?? "";
    UserModel userModel =
        user.isEmpty ? UserModel() : UserModel.fromJson(json.decode(user));
    return userModel;
  }

  Future<AdModel?> readAds() async {
    await init();
    String ads = sp.getString(Pref.adsDataKey) ?? "";
    AdModel adModel =
        ads.isEmpty ? AdModel() : AdModel.fromJson(json.decode(ads));
    return adModel;
  }

  Future<bool> setFirstUser() async {
    await init();
    return sp.setInt(Pref.isFirstTime, 1);
  }

  Future<String> getIndex() async {
    await init();
    return sp.getString(Pref.listIndex) ?? "";
  }

  static Future<bool> isFirstTime() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    int firstTime = sp.getInt(Pref.isFirstTime) ?? 0;
    return firstTime == 0 ? true : false;
  }

  Future<bool> resetUser() async {
    await init();
    sp.remove(Pref.isLoggedIN);
    return sp.remove(Pref.userDataKey);
  }

  Future<bool> checkLogin() async {
    await init();
    return sp.getBool(Pref.isLoggedIN) ?? false;
  }

  getAutoProtect() async {
    await init();
    return sp.getString(Pref.autoProtectKey) ?? "";
  }

  saveAutoProtect(dynamic val) async {
    await init();
    return sp.setString(Pref.autoProtectKey, val);
  }
}

class Pref {
  static String listIndex = "SelectedIndex";
  static String isFirstTime = "FirstTimeUser";
  static String isLoggedIN = "isLoggedIN";
  static String userDataKey = "userDataKey";
  static String adsDataKey = "adsDataKey";
  static String autoProtectKey = "autoProtect";
}
