import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tag_vpn/LocalData/PrefManager.dart';
import 'package:tag_vpn/Screens/loginscreen/login.dart';
import 'package:tag_vpn/Screens/signupscreen/signupscreen.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/constants/button.dart';
import 'package:tag_vpn/constants/sizes.dart';
import 'package:tag_vpn/Screens/homescreen/homescreen.dart';
import 'package:tag_vpn/widgets/Container/Container.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:tag_vpn/widgets/text.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentPage != 2) {
        _currentPage++;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skipImages = [
      "assets/images/onboarding1.png",
      "assets/images/onboarding2.png",
      "assets/images/onboarding3.png"
    ];
    final titles = [
      "Surf the web securely",
      "Ultra-fast Streaming",
      "Privacy you can trust"
    ];
    final imagesText = [
      "Enjoy no ads or time limits, and connect securely to 100+ locations with premium.",
      "Browse, game or stream from Netflix, Hulu, Disney+and more with no lag.",
      "Protect your privacy, digital life, and discover new opportunities"
    ];
    return GradientBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 20),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      for (var i = 0; i < 3; i++) ...[
                        Column(
                          children: [
                            Image.asset(
                              skipImages[i],
                              fit: BoxFit.cover,
                            ),
                            Utils.verticalSpacer(16),
                            Center(
                                child: SmoothPageIndicator(
                                    effect: const WormEffect(
                                        dotHeight: 12, dotWidth: 12),
                                    controller: _pageController,
                                    count: 3)),
                            Utils.verticalSpacer(16),
                            Center(
                              child: MyText(
                                text: titles[i],
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Utils.verticalSpacer(10),
                            Expanded(
                              child: MyText(
                                textAlignment: TextAlign.center,
                                text: imagesText[i],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width,
                    child: customButton(
                        text: 'Log In',
                        borderRadius: 10,
                        onPressed: () async {
                          await PrefManager().setFirstUser();
                          Utils.navigateAndRemoveA(page: LoginScreen());
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
