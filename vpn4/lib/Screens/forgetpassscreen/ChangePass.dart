import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Screens/loginscreen/login.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/AuthModel.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/widgets/SubmitButton.dart';
import 'package:tag_vpn/widgets/text.dart';

import '../../widgets/Container/Container.dart';
import '../../widgets/TextField.dart';

class ChangePassScreen extends StatefulWidget {
  final String email;
  const ChangePassScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Utils.verticalSpacer(52),
                Align(
                  alignment: Alignment.topRight,
                  child: MyContainer(
                      onPressed: () => Get.back(),
                      radius: 12,
                      height: 40,
                      width: 40,
                      color: MyColors.paneCyan,
                      child: Icon(
                        Icons.close,
                        color: MyColors.black,
                        size: 25,
                      )),
                ),
                Utils.verticalSpacer(24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: 'Change\nPassword',
                    fontSize: 40,
                  ),
                ),
                Utils.verticalSpacer(16),
                MyText(
                  text: 'Create account and enjoy 7 day free trial',
                  fontSize: 14,
                  fontColor: MyColors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
                Utils.verticalSpacer(40),
                TextFieldWidget(
                    isObscure: true,
                    hint: "Enter your password",
                    label: "Password",
                    controller: passwordController),
                Utils.verticalSpacer(24),
                TextFieldWidget(
                    isObscure: true,
                    hint: "Confirm your password",
                    label: "Confirm Password",
                    controller: repasswordController),
                Utils.verticalSpacer(24),
                Consumer<AuthViewModel>(builder: (_, provider, __) {
                  return SubmitButton(
                      isLoading: provider.loading,
                      text: "Change Password",
                      onPress: () {
                        if (passwordController.text.isNotEmpty &&
                            repasswordController.text.isNotEmpty &&
                            passwordController.text ==
                                repasswordController.text) {
                          var data = {
                            "email": widget.email,
                            "password": passwordController.text,
                          };
                          provider.changePass(context, data);
                        } else {
                          Utils.snackBarDefaultMessage(
                              message: "Password does not match",
                              context: context);
                        }
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      this.isObscure = false});

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: label,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        Utils.verticalSpacer(8),
        MyTextField(
          obscureIcon: isObscure,
          isObscure: isObscure,
          controller: controller,
          hintText: hint,
        ),
      ],
    );
  }
}
