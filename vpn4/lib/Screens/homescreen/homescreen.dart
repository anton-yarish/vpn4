// ignore_for_file: no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Screens/homescreen/widgets/FaqsScreen.dart';
import 'package:tag_vpn/Screens/homescreen/widgets/MapWidget.dart';
import 'package:tag_vpn/Screens/privacyscreen/privacypolicy.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/constants/button.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/Screens/homescreen/widgets/drawer.dart';
import 'package:tag_vpn/Screens/homescreen/widgets/ServersList.dart';
import 'package:tag_vpn/constants/sizes.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';
import 'package:tag_vpn/widgets/text.dart';

import '../../ViewModel/MainModel.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String? title;
  String? flag;
  HomeScreen({this.title, this.flag, Key? key})
      : super(
          key: key,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainViewModel>().checkInfoVPN(context);
      context.read<MainViewModel>().loadMap(context);
      context.read<MainViewModel>().getIpAdress();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: GradientBG(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: scaffoldkey,
          appBar: PreferredSize(
              preferredSize: Size(width, 50),
              child: AppBarWidget(scaffoldkey: scaffoldkey)),
          backgroundColor: Colors.transparent,
          drawer: const MyDrawer(),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Utils.verticalSpacer(20),
                    const MapWidget(),
                    Consumer<MainViewModel>(builder: (_, provider, __) {
                      var item = provider.regionList[provider.selectedIndex[0]]
                          .servers![provider.selectedIndex[1]];

                      return SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            provider.isConnected
                                ? MyText(
                                    height: 2,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    text: provider.openVpnStatus!.duration!,
                                  )
                                : SizedBox.fromSize(
                                    size: const Size.fromHeight(22),
                                  ),
                            SizedBox(
                              height: 230,
                              child: provider.isConnecting
                                  ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Lottie.asset(
                                            "assets/anim/water-animation.json",
                                            height: 140,
                                            width: 140),
                                        Lottie.asset("assets/anim/circle.json",
                                            height: 165)
                                      ],
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        if (!provider.isConnecting) {
                                          if (provider.isConnected) {
                                            provider.stopOpenVPN();

                                            Future.delayed(const Duration(
                                                    milliseconds: 5000))
                                                .then((value) {
                                              provider.getIpAdress();
                                            });
                                          } else {
                                            provider.updateMapPosition();
                                            provider.connectOpenVPN(context);
                                            Future.delayed(const Duration(
                                                    milliseconds: 5000))
                                                .then((value) {
                                              provider.getIpAdress();
                                            });
                                          }
                                        } else {
                                          Utils.snackBarDefaultMessage(
                                              context: context,
                                              message:
                                                  "Connecting is in progress");
                                        }
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Visibility(
                                            visible: provider.isConnected,
                                            child: Lottie.asset(
                                                "assets/anim/connected.json",
                                                animate: provider.isConnected,
                                                height: 230,
                                                width: 230),
                                          ),
                                          Image.asset(
                                            provider.isConnected
                                                ? "assets/images/connected.png"
                                                : "assets/images/disconnect.png",
                                            height: 140,
                                            width: 140,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyText(
                                  text: "Status",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                /*  TextButton(
                                    onPressed: () {
                                      provider.getIpAdress();
                                    },
                                    child: Text("asdasdasd")), */
                                Utils.verticalSpacer(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: provider.isConnected,
                                      child: Icon(
                                        Icons.circle,
                                        color: MyColors.greenColor,
                                        size: 12,
                                      ),
                                    ),
                                    Utils.horizontalSpacer(6),
                                    MyText(
                                      text: provider.isConnected
                                          ? "Connected"
                                          : provider.isConnecting
                                              ? "Please wait"
                                              : "Not Connected",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontColor: provider.isConnected
                                          ? MyColors.greenColor
                                          : provider.isConnecting
                                              ? Colors.white
                                              : MyColors.redTextColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Utils.verticalSpacer(24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ServerListItem(
                                onPress: () {
                                  selectServer(context);
                                },
                                selectedItem: true,
                                title: item.serverName!,
                                flagUrl: item.flagURL!,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Consumer<MainViewModel>(builder: (_, value, __) {
                      double bytein = value.isConnected
                          ? double.parse(value.openVpnStatus!.byteIn!)
                          : 0;
                      double byteout = value.isConnected
                          ? double.parse(value.openVpnStatus!.byteOut!)
                          : 0;

                      return Column(
                        children: [
                          SizedBox(
                            height: double.tryParse("50"),
                          ),
                          Column(
                            children: [
                              MyText(
                                text: value.isConnected
                                    ? "Your IP is protected"
                                    : "Your IP is not protected",
                              ),
                              Utils.verticalSpacer(6),
                              value.isIpLoaded
                                  ? MyText(
                                      text:
                                          context.read<MainViewModel>().wifiIp!,
                                      fontSize: 18,
                                    )
                                  : const CircularProgressIndicator()
                            ],
                          ),
                          Utils.verticalSpacer(16),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward_sharp,
                                    color: MyColors.textDefaultColor,
                                  ),
                                  Utils.horizontalSpacer(8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyText(
                                        text:
                                            "${Utils().formatBytes(bytein.floor(), 0)}/s",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Utils.verticalSpacer(8),
                                      MyText(
                                        text: "Download",
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const SizedBox(
                                height: 25,
                                child: VerticalDivider(
                                  color: Colors.white,
                                  thickness: 1,
                                  width: 20,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    color: MyColors.textDefaultColor,
                                  ),
                                  Utils.horizontalSpacer(8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyText(
                                        text:
                                            "${Utils().formatBytes(byteout.floor(), 0)}/s",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Utils.verticalSpacer(8),
                                      MyText(
                                        text: "Upload",
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Utils.verticalSpacer(16),
                        ],
                      );
                    })
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future<dynamic> selectServer(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      context: context,
      builder: (context) => GradientBG(
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.85,
          margin: const EdgeInsets.all(16),
          child: const SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: ServersList()),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.scaffoldkey,
  });

  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.appColor,
          ),
          child: IconButton(
              padding: const EdgeInsets.all(0),
              splashRadius: 20,
              color: whiteColor,
              iconSize: 15,
              onPressed: () => {Utils.navigate(page: const FaqsScreen())},
              icon: const Icon(
                Icons.question_mark_rounded,
              )),
        )
      ],
      centerTitle: true,
      title: Center(
        child: MyText(
          text: "VPN4",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            if (scaffoldkey.currentState!.isDrawerOpen) {
              scaffoldkey.currentState!.closeDrawer();
            } else {
              scaffoldkey.currentState!.openDrawer();
            }
          },
          icon: const Image(
            image: AssetImage("assets/images/menu.png"),
            height: 16,
            color: Colors.white,
          )),
      elevation: 0,
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
    );
  }
}
