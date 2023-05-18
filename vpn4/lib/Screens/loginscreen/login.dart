import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Screens/forgetpassscreen/ForgetScreen.dart';
import 'package:tag_vpn/Screens/signupscreen/signupscreen.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/AuthModel.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/widgets/Container/Container.dart';
import 'package:tag_vpn/widgets/SubmitButton.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:tag_vpn/widgets/text.dart';
import '../../widgets/TextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GradientBG(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Utils.verticalSpacer(24),
                    MyText(
                      text: 'Welcome\nBack',
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                    Utils.verticalSpacer(16),
                    MyText(
                      text: 'Login to continue',
                      fontSize: 14,
                      fontColor: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                    ),
                    Utils.verticalSpacer(40),
                    MyText(
                      text: 'Email',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    Utils.verticalSpacer(8),
                    MyTextField(
                      controller: emailController,
                      hintText: "Enter Your email",
                    ),
                    Utils.verticalSpacer(24),
                    MyText(
                      text: 'Password',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    Utils.verticalSpacer(8),
                    MyTextField(
                      controller: passwordController,
                      hintText: "Enter your password",
                      obscureIcon: true,
                      isObscure: true,
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Utils.navigate(page: const ForgetScreen());
                    //   },
                    //   child: Align(
                    //     alignment: Alignment.centerRight,
                    //     child: MyText(
                    //       text: 'Forgot Your Password?',
                    //       fontColor: Palette.appColor,
                    //       fontSize: 15,
                    //     ),
                    //   ),
                    // ),
                    Utils.verticalSpacer(24),
                    Consumer<AuthViewModel>(builder: (_, provider, __) {
                      return SubmitButton(
                          isLoading: provider.loading,
                          text: "Log In",
                          onPress: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              var data = {
                                "email": emailController.text.toString(),
                                "password": passwordController.text.toString(),
                              };
                              provider.login(context, data);
                            } else {
                              Utils.snackBarDefaultMessage(
                                  context: context,
                                  message: "Please fill all the fields");
                            }
                          });
                    }),
                    Utils.verticalSpacer(12),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     MyText(
                    //       text: "Don't have an account?",
                    //       fontSize: 15,
                    //     ),
                    //     TextButton(
                    //       child: MyText(
                    //         text: 'Create New',
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w600,
                    //         fontColor: Palette.appColor,
                    //       ),
                    //       onPressed: () {
                    //         Utils.navigate(page: SignupScreen());
                    //       },
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
