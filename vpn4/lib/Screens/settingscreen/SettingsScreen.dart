import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tag_vpn/Screens/settingscreen/AccountScreen.dart';
import 'package:tag_vpn/Screens/settingscreen/AutoProtect.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';
import 'package:tag_vpn/ViewModel/UserVModel.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:tag_vpn/widgets/text.dart';

import '../loginscreen/login.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<SettingModel> settingsList = [
    SettingModel(
        title: 'Account',
        subtitle: "Looking for information",
        imageData: "assets/settings/profile.png"),
    SettingModel(
        title: 'Auto - Protect',
        subtitle: "Keep your Fully Protected",
        imageData: "assets/settings/secure.png"),
    // SettingModel(
    //     title: 'Change Language',
    //     subtitle: "Click here to change language",
    //     imageData: "assets/settings/killswitch.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GradientBG(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: MyText(
              text: "Settings",
              fontSize: 15,
              fontColor: MyColors.textDefaultColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Utils.verticalSpacer(24),
                    MyText(
                      text: 'SECURITY',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    Utils.verticalSpacer(24),
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => settingItem(
                              onTap: () {
                                if (index == 0) {
                                  context.read<UserVModel>().isLoggedIn
                                      ? Utils.navigate(
                                          page: const AccountScreen())
                                      : Utils.navigate(
                                          page: const LoginScreen());
                                } else if (index == 1) {
                                  Utils.navigate(page: const AutoProtect());
                                }
                                // else if (index == 2) {
                                //   Utils.navigate(page: LanguageSelection());
                                // }
                              },
                              title: settingsList[index].title!,
                              subtitle: settingsList[index].subtitle!,
                              imageData: settingsList[index].imageData!,
                            ),
                        separatorBuilder: (context, index) =>
                            Utils.verticalSpacer(16),
                        itemCount: settingsList.length),
                    Utils.verticalSpacer(8),
                    Divider(
                      color: MyColors.ultraMarine,
                      thickness: 0.5,
                    ),
                    Utils.verticalSpacer(24),
                    MyText(
                      text: 'ADDITIONAL',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    Utils.verticalSpacer(16),
                    settingItem(
                        onTap: () {
                          Share.share(
                              "https://play.google.com/store/apps/details?id=com.vpn4");
                        },
                        title: "Share the app",
                        subtitle:
                            "Reestablishes VPN connection automatically If it fails.",
                        imageData: "assets/settings/share.png"),
                    settingItem(
                        onTap: () => Utils.launchWebUrlExternal(
                            "https://play.google.com/store/apps/details?id=com.vpn4"),
                        title: "Rate us on Google play",
                        subtitle:
                            "Reestablishes VPN connection automatically If it fails.",
                        imageData: "assets/settings/playstore.png"),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class settingItem extends StatelessWidget {
  const settingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageData,
    this.trailing,
    this.onTap,
  });

  final String title, subtitle, imageData;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(
          imageData,
          color: Colors.white,
          height: 24,
          width: 24,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: title,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            MyText(
              text: subtitle,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingModel {
  String? title, subtitle, trailing, onTap, imageData;

  SettingModel(
      {this.title, this.subtitle, this.imageData, this.trailing, this.onTap});
}
