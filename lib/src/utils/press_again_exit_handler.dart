import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PressAgainExitHandler {
  static DateTime? currentBackPressTime;

  static void onPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tekan kembali untuk keluar');
      return;
    }
    debugPrint('Exiting app');
    SystemNavigator.pop();
  }
}
