import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:tag_vpn/Utils/Colors.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/MainModel.dart';
import 'package:tag_vpn/widgets/gradientBg.dart';

import '../../widgets/text.dart';

class AutoProtect extends StatefulWidget {
  const AutoProtect({super.key});

  @override
  State<AutoProtect> createState() => _AutoProtectState();
}

class _AutoProtectState extends State<AutoProtect> {
  @override
  Widget build(BuildContext context) {
    return GradientBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: MyText(
            text: 'Auto - Protect',
            fontSize: 15,
            fontColor: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            Utils.verticalSpacer(24),
            MyText(
              text:
                  'Activate auto-connection to VPN4 to Keep you fully protected',
              fontSize: 15,
            ),
            Utils.verticalSpacer(24),
            Consumer<MainViewModel>(builder: (context, provider, child) {
              return ListView.separated(
                  separatorBuilder: (context, index) =>
                      Utils.verticalSpacer(16),
                  shrinkWrap: true,
                  itemCount: provider.titles.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: provider.titles[index],
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              Utils.verticalSpacer(4),
                              MyText(
                                text: provider.subtitles[index],
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                        Radio(
                            focusColor: Colors.blue,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            fillColor: MaterialStateProperty.all(
                                index == 2 ? Colors.red : Colors.blue),
                            activeColor: Colors.white,
                            value: provider.autoProtectValues[index].toString(),
                            groupValue: provider.autoProtectValue,
                            onChanged: (value) {
                              provider.saveAutoProtectValue(value.toString());
                            }),
                      ],
                    );
                  });
            }),
          ]),
        ),
      ),
    );
  }
}
