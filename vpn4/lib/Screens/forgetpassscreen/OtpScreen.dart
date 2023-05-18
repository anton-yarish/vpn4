import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Screens/forgetpassscreen/ChangePass.dart';
import 'package:tag_vpn/Screens/forgetpassscreen/ForgetScreen.dart';

import '../../Utils/Colors.dart';
import '../../Utils/Utils.dart';
import '../../ViewModel/AuthModel.dart';
import '../../constants/colors.dart';
import '../../widgets/Container/Container.dart';
import '../../widgets/SubmitButton.dart';
import '../../widgets/TextField.dart';
import '../../widgets/text.dart';

class OtpScreen extends StatefulWidget {
  final String email, otp;
  const OtpScreen({super.key, required this.email, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController emailController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
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
                    text: 'Verification',
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                  Utils.verticalSpacer(16),
                  MyText(
                    text:
                        'We have sent the OTP code to the email ${widget.email}',
                    fontSize: 14,
                    fontColor: MyColors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w400,
                  ),
                  Utils.verticalSpacer(40),
                  // MyText(
                  //   text: 'Email',
                  //   fontSize: 15,
                  //   fontWeight: FontWeight.w600,
                  // ),
                  // Utils.verticalSpacer(8),
                  PinCodeTextField(
                    length: 5,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: 54,
                      fieldWidth: 54,
                      borderWidth: 1,
                      inactiveFillColor: MyColors.greyColor,
                      // disabledColor: MyColors.greyColor,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    controller: emailController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                  Utils.verticalSpacer(50),
                  Consumer<AuthViewModel>(builder: (_, provider, __) {
                    return SubmitButton(
                        isLoading: provider.loading,
                        text: "Verify OTP",
                        onPress: () {
                          if (currentText.length == 5) {
                            if (currentText == widget.otp) {
                              Utils.navigate(
                                  page: ChangePassScreen(
                                email: widget.email,
                              ));
                              Utils.snackBarDefaultMessage(
                                  context: context,
                                  message: "Successfully Verified");
                            } else {
                              Utils.snackBarDefaultMessage(
                                  context: context, message: "Invalid OTP");
                            }
                          } else {
                            Utils.snackBarDefaultMessage(
                                context: context,
                                message: "Please put the OTP");
                          }
                        });
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
