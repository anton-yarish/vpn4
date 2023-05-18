import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:tag_vpn/Screens/onboardingscreen/onboardingscreen.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/constants/button.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/Screens/privacyscreen/privacypolicy.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:tag_vpn/widgets/text.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> options = [
      "Device-specific information like OS version, hardware model, and IP address to optimize our  network connection to you. We do not store or  log your IP address after you disconnect from  the VPN.",
      "Aggregated anonymous website activity data, to  perform analytics on our Service and to ensure  you can reliably access certain websites or apps.",
      "Payment information and optional email, when  you purchase a paid plan"
    ];

    Size screenSize = WidgetsBinding.instance.window.physicalSize;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: GradientBG(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Your Privacy is Our Priority",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text:
                          "We do not keep logs of your online activities and never associate any domains or applications that you use with you, your device, IP address, or email.",
                      fontSize: 13,
                      textAlignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text:
                          "Android VPN4 collects a minimal amount of data to offer you a fast and reliable VPN service.",
                      fontSize: 13,
                      textAlignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                      text: "We Collect:",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      textAlignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: List.generate(
                        options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Icon(
                                  Icons.circle,
                                  size: 4,
                                ),
                              ),
                              Utils.horizontalSpacer(5),
                              Expanded(
                                child: MyText(
                                  text: options[index],
                                  fontSize: 13,
                                  textAlignment: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "\nFor more information, please read our ",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Utils.navigate(page: PrivacyPolicy());
                            },
                          text: "Privacy Policy",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          )),
                    ])),
                  ],
                ),
                SizedBox(
                    width: width,
                    child: customButton(
                        text: "Accept & Continue",
                        onPressed: () => {
                              Utils.navigateAndRemoveA(
                                  page: const OnBoardingScreen())
                            })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
