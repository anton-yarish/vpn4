import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:tag_vpn/LocalData/PrefManager.dart';
import 'package:tag_vpn/Model/UserModel.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';

import '../Model/UserModel.dart';

class UserVModel with ChangeNotifier {
  static bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  static UserModel? _userModel;
  get userModel => _userModel;
  MainViewModel _mainViewModel = MainViewModel();
  UserVModel() {
    checkUser();
  }

  logout() async {
    _mainViewModel.checkInfoVPNToLogOut();
    _mainViewModel.stopOpenVPN();
    await PrefManager().resetUser().then((value) {
      checkUser();
    });

    notifyListeners();
  }

  checkUser() async {
    _userModel = await PrefManager().readUser();
    _isLoggedIn = await PrefManager().checkLogin();
    notifyListeners();
  }
}
