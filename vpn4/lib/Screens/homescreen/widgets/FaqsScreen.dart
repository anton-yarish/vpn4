import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';

import '../../../Utils/Utils.dart';
import '../../../widgets/Container/Container.dart';
import '../../../widgets/text.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<FaqsModel> faqs = [
    FaqsModel(
        question: "Why I need VPN4?",
        answer:
            "VPN4 is virtual private network. It allows you to stay private, and access any online content you want-no matter where you are."),
    FaqsModel(
        question: "Is it Safe?",
        answer:
            "We use SSL to encrypt your internet data. Your data is undecipherable to prying eyes while in transit. Moreover, we do not collect, log, store, share any data log belonging to users, and please feel safe to use our product. "),
    FaqsModel(
        question: "How to use VPN4?",
        answer:
            "Click connect button in the main screen to use VPN4. If android system shows a dialog to request connection permission, click OK or accept to continue. "),
    FaqsModel(
        question: "How to disconnect VPN4?",
        answer:
            "Click the same connect button on the home page to disconnect VPN."),
    FaqsModel(
        question: "How to select IP, server or region you prefer?",
        answer:
            "Please click the notional flag at the top right of toolbar in homepage. Then choose IP, region server you prefer and connect. "),
    FaqsModel(
        question: "Is it free to use VPN4?",
        answer:
            "We have 5 free trials for you to try and experience VPN4 service, after that you have to upgrade your account to premium to get unlimited connections."),
    FaqsModel(
        question: "Can’t connect, not stable or speed slowly.",
        answer:
            "Connection problem is affected by many factors, Please update to the latest version, refresh the server list and connect to the top server tor servile times. If still does not work for you, please contact us via support@tagvpn.co and provide us with your country and network provider name."),
    FaqsModel(
        question: "What is smart proxy?",
        answer:
            "One Android or above, you can only enable some of the apps to use VPN4 to proxy traffic, For example, if Facebook and Skype and Streaming or Gaming are blocked in your country, make them checks in smart proxy. After the VPN connection is established. Only Facebook and Skype’s and Streaming or Gaming traffic go through VPN, and all your other apps will perform as good as usual."),
  ];
  @override
  Widget build(BuildContext context) {
    return GradientBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_rounded,
              )),
          title: Text("FAQs"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text:
                    "In here you can find the most asked questions about VPN4",
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              Utils.verticalSpacer(23),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Utils.verticalSpacer(12),
                    itemCount: faqs.length,
                    itemBuilder: (_, index) {
                      var item = faqs[index];
                      return MyContainer(
                          color: MyColors.greyColor,
                          radius: 8,
                          child: ExpansionTile(
                            controlAffinity: ListTileControlAffinity.platform,
                            onExpansionChanged: (value) {},
                            tilePadding:
                                const EdgeInsets.only(left: 18, right: 20),
                            expandedCrossAxisAlignment: CrossAxisAlignment.end,
                            iconColor:
                                MyColors.textDefaultColor.withOpacity(0.50),
                            collapsedIconColor: MyColors.textDefaultColor,
                            childrenPadding:
                                const EdgeInsets.fromLTRB(18, 0, 40, 13),
                            title: MyText(
                              text: item.question,
                              fontWeight: FontWeight.w500,
                              fontColor: Colors.black,
                            ),
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: MyText(
                                  text: item.answer,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontColor: MyColors.textDefaultColor
                                      .withOpacity(0.70),
                                ),
                              ),
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqsModel {
  String question;
  String answer;

  FaqsModel({required this.question, required this.answer});
}
