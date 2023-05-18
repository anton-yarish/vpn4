import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/ViewModel/AuthModel.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';
import 'package:tag_vpn/ViewModel/UserVModel.dart';
import 'package:tag_vpn/widgets/Container/Container.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';

import '../../Utils/Colors.dart';
import '../../Utils/Utils.dart';
import '../../widgets/text.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: MyText(
            text: 'Account Info',
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Consumer<UserVModel>(builder: (_, provider, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils.verticalSpacer(24),
                MyText(
                  text: "Here's your VPN4 Account.",
                  fontSize: 15,
                ),
                Utils.verticalSpacer(24),
                MyContainer(
                  alignment: Alignment.centerLeft,
                  color: MyColors.greyColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 5),
                    child: AccountItem(
                      title: 'User Name',
                      subtitle: provider.isLoggedIn
                          ? provider.userModel!.data!.name
                          : "Null",
                    ),
                  ),
                ),
                Utils.verticalSpacer(16),
                MyContainer(
                  alignment: Alignment.centerLeft,
                  color: MyColors.greyColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 5),
                    child: AccountItem(
                      title: 'Email Address',
                      subtitle: provider.isLoggedIn
                          ? provider.userModel!.data!.email
                          : "Null",
                    ),
                  ),
                ),
                // Utils.verticalSpacer(16),
                // MyContainer(
                //   alignment: Alignment.centerLeft,
                //   color: MyColors.greyColor,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 5),
                //     child: AccountItem(
                //       title: 'Renewal Date',
                //       subtitle: context.read<MainViewModel>().isPremiumUser
                //           ? "20 / 04 / 2023"
                //           : "No Subscription",
                //     ),
                //   ),
                // ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  String title, subtitle;
  AccountItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title,
          fontSize: 16,
          fontColor: MyColors.textDefaultColor,
          fontWeight: FontWeight.w500,
        ),
        Utils.verticalSpacer(6),
        MyText(
          text: subtitle,
          fontColor: MyColors.textDefaultColor,
          fontSize: 12,
        ),
      ],
    );
  }
}
