import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
// import 'package:device_apps/device_apps.dart';

class OpenOtherAppHandler {
  static void open(String packageName) async {
    if (Platform.isIOS) {
      return;
    }
    // final bool openSuccess = await DeviceApps.openApp(packageName);
    // if (openSuccess) return;
    AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: 'https://play.google.com/store/apps/details?'
          'id=$packageName',
    );
    await intent.launch();
  }
}
