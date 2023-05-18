import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tag_vpn/constants/colors.dart';
import 'package:tag_vpn/Screens/privacyscreen/privacyscreen.dart';

String data = '';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _YourPolicyState();
}

class _YourPolicyState extends State<PrivacyPolicy> {
  var path = 'assets/misc/privacypolicy.txt';
  fetchFileData(path) async {
    String responseText;

    responseText = await rootBundle.loadString(path);

    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    fetchFileData(path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const PrivacyScreen())),
            icon: const Icon(
              Icons.arrow_back_rounded,
            )),
        title: const Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          data,
          style: TextStyle(color: blackColour),
          textAlign: TextAlign.justify,
        ),
      )),
    );
  }
}
