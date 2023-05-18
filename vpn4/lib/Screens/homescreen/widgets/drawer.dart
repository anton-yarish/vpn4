// ignore_for_file: avoid_print
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/LocalData/PrefManager.dart';
import 'package:tag_vpn/Screens/loginscreen/login.dart';
import 'package:tag_vpn/Screens/privacyscreen/privacypolicy.dart';
import 'package:tag_vpn/Screens/settingscreen/SettingsScreen.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/UserVModel.dart';
import 'package:tag_vpn/constants/button.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'FaqsScreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@codeware.digital',
      query: encodeQueryParameters(<String, String>{
        'subject': 'VPN4 Support',
      }),
    );
    final drawerIconsName = [
      "Contact Support",
      "Settings",
      "Privacy Policy",
      "FAQ"
    ];
    final drawerIcons = [
      Icons.headphones,
      Icons.settings,
      Icons.privacy_tip,
      Icons.question_mark,
    ];

    List<VoidCallback> drawerAction = [
      () => launchUrl(emailLaunchUri),
      () => Utils.navigate(page: const SettingsScreen()),
      () => Utils.navigate(page: const PrivacyPolicy()),
      () => Utils.navigate(page: const FaqsScreen()),
    ];

    return GradientBG(
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(16))),
        child: Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.loose,
          children: [
            Positioned(
                top: 30,
                right: 22,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                      color: Palette.appColor,
                    ))),
            Positioned(
              top: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  "assets/images/icon.png",
                  fit: BoxFit.scaleDown,
                  height: 70,
                  width: 70,
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Consumer<UserVModel>(builder: (_, provider, __) {
                return Text.rich(
                  TextSpan(
                    style: const TextStyle(color: Colors.white),
                    text: provider.isLoggedIn
                        ? provider.userModel!.data!.email
                        : "example@gmail.com",
                    children: [
                      TextSpan(
                        text: provider.isLoggedIn ? " Sign out" : " Sign in",
                        style: TextStyle(color: Palette.appColor.shade300),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (provider.isLoggedIn) {
                              provider.logout();

                              Utils.navigateAndRemoveA(
                                  page: const LoginScreen());
                            }
                          },
                      ),
                    ],
                  ),
                );
              }),
            ),
            Positioned(
              top: 220,
              child: SizedBox(
                height: 500,
                width: 272,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: customIconButton(
                            borderRadius: 10,
                            alignment: Alignment.centerLeft,
                            foregroundColor: MyColors.textDefaultColor,
                            backgroundColor: whiteColor,
                            width: 272,
                            height: 46,
                            leading: Icon(drawerIcons[index]),
                            onPressed: drawerAction[index],
                            trailing: Text(drawerIconsName[index])),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
