// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../helpers/my_dialogs.dart';
// import '../helpers/pref.dart';
// import '../models/vpn.dart';
// import '../models/vpn_config.dart';
// import '../services/vpn_engine.dart';

// class HomeController extends GetxController {
//   final Rx<Vpn> vpn = Pref.vpn.obs;

//   final vpnState = VpnEngine.vpnDisconnected.obs;

//   void connectToVpn() async {
//     if (vpn.value.openVPNConfigDataBase64.isEmpty) {
//       MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
//       return;
//     }

//     if (vpnState.value == VpnEngine.vpnDisconnected) {
//       // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}');

//       final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
//       final config = Utf8Decoder().convert(data);
//       final vpnConfig = VpnConfig(
//         country: vpn.value.countryLong,
//         username: 'vpn',
//         password: 'vpn',
//         config: config,
//       );

//       // log('\nAfter: $config');

//       //code to show interstitial ad and then connect to vpn
//       await VpnEngine.startVpn(vpnConfig);
//     } else {
//       await VpnEngine.stopVpn();
//     }
//   }

//   // vpn buttons color
//   Color get getButtonColor {
//     switch (vpnState.value) {
//       case VpnEngine.vpnDisconnected:
//         return Colors.blue;

//       case VpnEngine.vpnConnected:
//         return Colors.green;

//       default:
//         return Colors.green.shade400;
//     }
//   }

//   // vpn button text
//   String get getButtonText {
//     switch (vpnState.value) {
//       case VpnEngine.vpnDisconnected:
//         return 'Tap to Connect';

//       case VpnEngine.vpnConnected:
//         return 'Disconnect';

//       default:
//         return 'Connecting...';
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/my_dialogs.dart';
import '../helpers/pref.dart';
import '../models/vpn.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn> vpn = Pref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() async {
    if (vpn.value.openVPNConfigDataBase64.isEmpty) {
      MyDialogs.info(msg: 'Select a Location by clicking \'Change Location\'');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      // log('\nBefore: ${vpn.value.openVPNConfigDataBase64}');

      final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);
      final vpnConfig = VpnConfig(
        country: vpn.value.countryLong,
        username: 'vpn',
        password: 'vpn',
        config: config,
      );

      // log('\nAfter: $config');

      //code to show interstitial ad and then connect to vpn
      await VpnEngine.startVpn(vpnConfig);
    } else {
      await VpnEngine.stopVpn();
    }
  }

  // vpn buttons color - updated to match new design requirements
  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.white; // White background with shadow

      case VpnEngine.vpnConnected:
        return Colors.green; // Green background

      default:
        return Colors.green.shade400; // Light green background
    }
  }

  // Get icon color based on VPN state
  Color get getIconColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue; // Blue icon on white background

      case VpnEngine.vpnConnected:
        return Colors.blue; // Blue icon on green background

      default:
        return Colors.yellow; // Yellow icon on light green background
    }
  }

  // vpn button text
  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}