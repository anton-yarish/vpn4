import 'package:flutter/material.dart';

class AuthProviderLogin with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(AuthProviderLogin.pattern.toString());

  void validationLogin(
      {required TextEditingController? uname,
      required TextEditingController? uemail,
      required TextEditingController? upassword,
      required BuildContext context}) async {
    if (uname!.text.trim().isEmpty || uemail!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Username Or Email")));
      return;
    } else if (upassword!.text.trim().isEmpty || upassword.text.length < 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Enter Password")));
      return;
    }
  }
}
