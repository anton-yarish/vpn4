import 'package:flutter/material.dart';

class AuthProviderSignup with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(AuthProviderSignup.pattern.toString());

  bool loading = false;

  void validationSignup(
      {required TextEditingController? uname,
      required TextEditingController? uemail,
      required TextEditingController? uphone,
      required TextEditingController? upassword,
      TextEditingController? uaddress,
      required BuildContext context}) async {
    if (uname!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter User Name")));
      return;
    } else if (uemail!.text.trim().isEmpty ||
        !regExp.hasMatch(uemail.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter A Valid Email Address")));
      return;
    } else if (uphone!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter Phone Number")));
      return;
    } else if (upassword!.text.trim().isEmpty || upassword.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please Enter A Valid Password")));
      return;
    } else {}
  }
}
