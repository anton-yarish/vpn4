import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Screens/loginscreen/login.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/AuthModel.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/widgets/SubmitButton.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:tag_vpn/widgets/text.dart';

import '../../widgets/Container/Container.dart';
import '../../widgets/TextField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientBG(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
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
                      text: 'Create\nAccount ',
                      fontSize: 40,
                    ),
                  ),
                  Utils.verticalSpacer(16),
                  MyText(
                    text: 'Create account and Submit for approval',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Utils.verticalSpacer(40),
                  TextFieldWidget(
                      hint: "Enter your name",
                      label: "Name",
                      controller: nameController),
                  Utils.verticalSpacer(24),
                  TextFieldWidget(
                      hint: "Enter your email address",
                      label: "Email",
                      controller: emailController),
                  Utils.verticalSpacer(24),
                  TextFieldWidget(
                      isObscure: true,
                      hint: "Enter your password",
                      label: "Password",
                      controller: passwordController),
                  Utils.verticalSpacer(24),
                  Consumer<AuthViewModel>(builder: (_, provider, __) {
                    return SubmitButton(
                        isLoading: provider.loading,
                        text: "Sign Up",
                        onPress: () {
                          if (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            var data = {
                              "name": nameController.text,
                              "email": emailController.text,
                              "password": passwordController.text,
                            };
                            provider.register(context, data);
                          } else {
                            Utils.snackBarDefaultMessage(
                                message: "Please fill all the fields",
                                context: context);
                          }
                        });
                  }),
                  Utils.verticalSpacer(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyText(
                        text: "Already have an account?",
                        fontSize: 15,
                      ),
                      TextButton(
                        child: MyText(
                          text: 'Login now',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontColor: Palette.appColor,
                        ),
                        onPressed: () {
                          Utils.navigate(page: const LoginScreen());
                        },
                      )
                    ],
                  ),
                ],
              ),
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
