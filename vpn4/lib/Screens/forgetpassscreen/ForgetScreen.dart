import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';

import '../../Utils/Colors.dart';
import '../../Utils/Utils.dart';
import '../../ViewModel/AuthModel.dart';
import '../../constants/colors.dart';
import '../../widgets/Container/Container.dart';
import '../../widgets/SubmitButton.dart';
import '../../widgets/TextField.dart';
import '../../widgets/text.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  alignment: Alignment.centerLeft,
                  child: MyContainer(
                      alignment: Alignment.center,
                      onPressed: () => Get.back(),
                      radius: 12,
                      height: 40,
                      width: 40,
                      color: MyColors.paneCyan,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 22,
                          color: MyColors.black,
                        ),
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Utils.verticalSpacer(24),
                    MyText(
                      text: 'Forgot\nPassword',
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                    Utils.verticalSpacer(16),
                    MyText(
                      text:
                          'Enter your email and we will send OTP code to recovery the password',
                      fontSize: 14,
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
                    Utils.verticalSpacer(50),
                    Consumer<AuthViewModel>(builder: (_, provider, __) {
                      return SubmitButton(
                          isLoading: provider.loading,
                          text: "Send OTP",
                          onPress: () {
                            var data = {
                              "email": emailController.text.trim(),
                            };
                            provider.forgetPass(context, data);
                          });
                    }),
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
