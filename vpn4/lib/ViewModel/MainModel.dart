import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tag_vpn/Model/AdModel.dart';
import 'package:tag_vpn/Model/ServerModel.dart';
import 'package:tag_vpn/Repositories/MainRepository.dart';
import 'package:tag_vpn/Screens/settingscreen/AutoProtect.dart';
import 'package:tag_vpn/Utils/Utils.dart';
import 'package:tag_vpn/ViewModel/PurchaseModel.dart';

import '../LocalData/PrefManager.dart';
import '../Utils/AdMobHelper.dart';
import '../main.dart';

class MainViewModel with ChangeNotifier {
  final _mainRepo = MainRepository();
  bool _isLoading = false;
  final bool _isSearching = false;
  bool get isSearching => _isSearching;
  bool get isLoading => _isLoading;
  bool _isConnected = false;
  bool _isIpLoaded = false;
  bool _isConnecting = false;
  //public ip address var
  String? wifiIp;
  bool get isIpLoaded => _isIpLoaded;
  bool get isConnected => _isConnected;
  bool get isConnecting => _isConnecting;
  bool _isPremiumUser = false;
  bool get isPremiumUser => _isPremiumUser;
  bool _adLoaded = false;
  bool _bannerAdLoaded = false;
  bool get bannerAdLoaded => _bannerAdLoaded;
  bool get adLoaded => _adLoaded;

  //servers list
  static List<Regions> _regionList = [];
  List<Regions> get regionList => _regionList;
  //selected server index
  List _selectedIndex = [0, 0];
  List get selectedIndex => _selectedIndex;

  Future<void> getIpAdress() async {
    wifiIp = await Ipify.ipv4();
    print(wifiIp);
    _isIpLoaded = true;
    notifyListeners();
  }

  Future setServerPosition(List val) async {
    _selectedIndex = val;
    PrefManager.saveListConnectedIndex(selectedIndex);
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setConnected(bool val) {
    _isConnected = val;
    notifyListeners();
  }

  void setConnecting(bool val) {
    _isConnecting = val;
    notifyListeners();
  }

// fetch servers method
  Future<bool> getServers() async {
    final response = await _mainRepo.fetchServers();
    if (response != null) {
      List jsonResponse = response["regions"];
      _regionList = jsonResponse.map((e) => Regions.fromJson(e)).toList();
      // await getAds();
      try {
        await getIpAdress();
      } catch (e) {
        if (kDebugMode) {
          print("Error fetching public IP $e");
        }
      }
    //  await PurchaseModel.fetchOffers();
      return true;
    } else {
      _regionList = [];
      return false;
    }
  }

  //fetch public IP Address
/*    Future<bool> fetchPublicIP() async {
    final response = await _mainRepo.fetchPublicIP();
    if (response != null) {
      _publicIP = response["YourFuckingIPAddress"];
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }  */

  // Future<bool> getAds() async {
  //   final response = await _mainRepo.fetchAds();
  //   if (response != null && response["response"] == "success") {
  //     try {
  //       await PrefManager().saveAds(response);
  //       loadSavedAds();
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print("Error saving ads $e");
  //       }
  //     }
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // loadSavedAds() async {
  //   AdModel? _adModel = await PrefManager().readAds();
  //   if (_adModel != null && _adModel.data != null) {
  //     var item = _adModel.data![0];
  //     AdHelper.androidBannerAdUnit = item.bannerID!;
  //     AdHelper.androidInterAdUnit = item.interstitialID!;
  //     AdHelper.androidRewardedAdUnit = item.rewardedID!;
  //     AdHelper.androidAppID = item.admobID!;

  //     try {
  //       await MyApp.channel.invokeMethod(
  //           'setAdMobAppId', {'admobAppId': AdHelper.androidAppID});
  //       loadAds();
  //     } on PlatformException catch (e) {
  //       print(e);
  //       // Handle the exception
  //     }
  //   }
  // }

  //open vpn
  late OpenVPN openvpn;
  VpnStatus? openVpnStatus;
  VPNStage? openVpnStage;
  bool vpnPermissionGranted = false;
  var connectionStatus = 'START SESSION';
  var currentAction = 'Not Connected';

  Future<void> initPlatformState(String config, String serverName,
      String userName, String password) async {
    List<String>? bypass = [];
    openvpn.connect(config, serverName,
        username: userName, password: password, certIsRequired: true);
    // if (!mounted) return;
  }

  Future<void> checkInfoVPN(BuildContext context) async {
    openvpn = OpenVPN(
      onVpnStatusChanged: (data) {
        openVpnStatus = data;
      },
      onVpnStageChanged: (data, raw) {
        openVpnStage = data;
        changeState(context);
        notifyListeners();
      },
    );

    //initialize openvpn for ios
    openvpn.initialize(
        groupIdentifier: "group.com.cnxvpn",
        providerBundleIdentifier: "com.cnxvpn.VPNExtension",
        localizedDescription: "VPN by Rauf_encoders");
    refreshIndex();
    getAutoProtectValue();

    notifyListeners();
  }

  Future<void> checkInfoVPNToLogOut() async {
    openvpn = OpenVPN(
      onVpnStatusChanged: (data) {
        openVpnStatus = data;
      },
      onVpnStageChanged: (data, raw) {
        openVpnStage = data;

        notifyListeners();
      },
    );

    //initialize openvpn for ios
    openvpn.initialize(
        groupIdentifier: "group.com.cnxvpn",
        providerBundleIdentifier: "com.cnxvpn.VPNExtension",
        localizedDescription: "VPN by Rauf_encoders");
    refreshIndex();
    getAutoProtectValue();

    notifyListeners();
  }

  changeState(BuildContext context) {
    if (openVpnStage == VPNStage.connected) {
      if (!isConnected) {
        setConnected(true);
        setConnecting(false);
        connectionStatus = 'Connected';
      }
    } else if (openVpnStage == VPNStage.disconnected) {
      setConnected(false);
      setConnecting(false);
      connectionStatus = 'START SESSION';
    } else if (openVpnStage == VPNStage.connecting) {
      connectionStatus = 'Connecting...';
      setConnecting(true);
      setConnected(false);
    } else if (openVpnStage == VPNStage.wait_connection) {
      connectionStatus = 'Connecting...';
      setConnected(false);
      setConnecting(true);
    } else if (openVpnStage == VPNStage.disconnecting) {
      connectionStatus = 'Disconnecting';
      setConnected(false);
      setConnecting(true);
    } else if (openVpnStage == VPNStage.authenticating) {
      setConnected(false);
      setConnecting(true);
      connectionStatus = 'Authenticating';
    } else if (openVpnStage == VPNStage.prepare) {
      setConnected(false);
      setConnecting(true);
      connectionStatus = 'Preparing';
    } else if (openVpnStage == VPNStage.error) {
      setConnected(false);
      setConnecting(false);
      connectionStatus = 'Error! Try again';
    }
  }

  void connectOpenVPN(BuildContext context) async {
    if (vpnPermissionGranted) {
      if (openVpnStage == VPNStage.disconnected) {
        startVPN();
        notifyListeners();
      } else if (openVpnStage == VPNStage.connected && isConnected) {
        openvpn.disconnect();
        notifyListeners();
      } else if (openVpnStage == VPNStage.connecting) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.wait_connection) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.authentication) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.error) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.get_config) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.prepare) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.vpn_generate_config) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.authenticating) {
        openvpn.disconnect();
      } else if (openVpnStage == VPNStage.assign_ip) {
        openvpn.disconnect();
      }
    } else {
      vpnPermissionGranted = (Platform.isAndroid)
          ? await openvpn.requestPermissionAndroid()
          : true;
      if (vpnPermissionGranted) {
        startVPN();
      }
    }
  }

  void stopOpenVPN() async {
    openvpn.disconnect();
    notifyListeners();
  }

  void reconnect(BuildContext context) async {
    stopOpenVPN();
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      startVPN();
    });
  }

  startVPN() async {
    dynamic item = regionList[selectedIndex[0]].servers![selectedIndex[1]];
    initPlatformState(
      item.ovpnConfiguration,
      item.serverName.toString(),
      item.vpnUserName.toString(),
      item.vpnPassword.toString(),
    );
  }

  Future<void> refreshIndex() async {
    String savedIndex = await PrefManager().getIndex();
    List savedIndices = savedIndex.isEmpty ? [0, 0] : jsonDecode(savedIndex);
    if (regionList[savedIndices[0]].servers!.length >= savedIndices[1]) {
      setServerPosition(savedIndices);
      notifyListeners();
    }
  }

//Auto protect screen
  String _autoProtectValue = "off";
  String get autoProtectValue => _autoProtectValue;
  List titles = ["Connect on device startup", "Unsecured Wi-Fi", "Off"];
  List subtitles = [
    "Auto-connection to VPN4 on device startup",
    "Auto-connection to VPN4 on unsecured Wi-Fi",
    "Your Connection might be unprotected"
  ];
  List autoProtectValues = [
    "ondevicestartup",
    "unsecuredwifi",
    "off",
  ];
  saveAutoProtectValue(String value) async {
    await PrefManager().saveAutoProtect(value);
    _autoProtectValue = value.toString();
    notifyListeners();
  }

  getAutoProtectValue() async {
    String savedValue = await PrefManager().getAutoProtect();
    if (savedValue.isNotEmpty) {
      _autoProtectValue = savedValue;
    }
    notifyListeners();
  }

  //Google Map Model

  static Set<Marker> _mapMarkers = {};
  Set<Marker> get mapMarkers => _mapMarkers;
  GoogleMapController? mapController;
  GoogleMapController? locMapController;
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng((34.03920402269985), (71.60101756693872)),
    zoom: 5.0,
  );
  CameraPosition lockGooglePlex = const CameraPosition(
    target: LatLng((34.03920402269985), (71.60101756693872)),
    zoom: 5.0,
  );
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  String mapTheme = "";
  // String mapLocTheme = "";

  loadMap(BuildContext context) async {
    DefaultAssetBundle.of(context)
        .loadString("assets/mapthemes/light_map.json")
        .then((value) {
      mapTheme = value;
    });

    dynamic item = regionList[selectedIndex[0]].servers![selectedIndex[1]];
    kGooglePlex = CameraPosition(
      target: LatLng(
          (item.latitude.toString().isEmpty)
              ? (34.03920402269985)
              : double.parse(item.latitude.toString()),
          (item.longitude.toString().isEmpty)
              ? (71.60101756693872)
              : double.parse(item.longitude.toString())),
      zoom: 4.5,
    );
    markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/primary_marker.png");
    for (var element in regionList[selectedIndex[0]].servers!) {
      Marker marker = Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(double.parse(element.latitude.toString()),
              double.parse(element.longitude.toString())),
          icon: markerIcon,
          infoWindow: InfoWindow(title: element.serverName));
      _mapMarkers.add(marker);
    }
    notifyListeners();
  }

  void updateMapPosition() async {
    try {
      var item = regionList[selectedIndex[0]].servers![selectedIndex[1]];
      GoogleMapController? controller = mapController;
      controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              double.parse(item.latitude!), double.parse(item.longitude!)),
          zoom: 4.5)));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    notifyListeners();
  }
}
