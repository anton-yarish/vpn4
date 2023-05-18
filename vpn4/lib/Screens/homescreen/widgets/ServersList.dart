import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/widgets/text.dart';
import 'package:flutter/foundation.dart';

class ServersList extends StatefulWidget {
  const ServersList({Key? key}) : super(key: key);

  @override
  State<ServersList> createState() => _ServersListState();
}

class _ServersListState extends State<ServersList> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Material(
            color: Colors.transparent,
            elevation: 0,
            shadowColor: blackColour,
            child: TextFormField(
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: MyColors.greyDarkShade,
                  size: 30,
                ),
                fillColor: MyColors.greyColor,
                hintText: "Search Location...",
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 12, color: MyColors.greyDarkShade),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Consumer<MainViewModel>(builder: (_, provider, __) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.regionList.length,
              itemBuilder: (context, regionIndex) {
                var regionItem = provider.regionList[regionIndex];
                return ListTile(
                  subtitle: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Utils.verticalSpacer(16),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: regionItem.servers!.length,
                      itemBuilder: (context, serverIndex) {
                        var serverItem = provider
                            .regionList[regionIndex].servers![serverIndex];
                        return ServerListItem(
                          onPress: () {
                            provider
                                .setServerPosition([regionIndex, serverIndex]);
                            provider.updateMapPosition();
                            provider.isConnected
                                ? provider.reconnect(context)
                                : provider.connectOpenVPN(context);

                            Future.delayed(const Duration(milliseconds: 5000))
                                .then((value) {
                              provider.getIpAdress();
                            });
                            Get.back();
                          },
                          selectedItem: listEquals(provider.selectedIndex,
                              [regionIndex, serverIndex]),
                          flagUrl: serverItem.flagURL!,
                          title: serverItem.serverName!,
                        );
                      }),
                  contentPadding: const EdgeInsets.all(0),
                  title: regionItem.servers!.isEmpty
                      ? null
                      : Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.0, top: regionIndex == 0 ? 20 : 0),
                          child: MyText(
                            text: regionItem.regionName!,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              });
        }),
      ],
    );
  }
}

// ignore: must_be_immutable
class ServerListItem extends StatelessWidget {
  final String flagUrl, title;
  VoidCallback? onPress;
  bool selectedItem;
  ServerListItem(
      {Key? key,
      required this.title,
      this.selectedItem = false,
      required this.flagUrl,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedItem ? Palette.appColor : whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        onTap: onPress,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Palette.appColor, width: 1),
            borderRadius: BorderRadius.circular(12)),
        dense: true,
        tileColor: selectedItem ? Palette.appColor : whiteColor,
        minLeadingWidth: 0.5,
        leading: CachedNetworkImage(
          imageUrl: flagUrl,
          width: 30,
          height: 30,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(
                  color: MyColors.textDefaultColor,
                  strokeWidth: 1,
                  value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        title: MyText(
          text: title,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          fontColor: Colors.black,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.wifi,
              color:
                  selectedItem ? Colors.black.withOpacity(0.7) : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
