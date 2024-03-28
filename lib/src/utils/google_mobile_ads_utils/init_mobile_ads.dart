import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InitMobileAds {
  static bool showAds = true;
  static bool testAds = false;
  static void init(
      {bool gRated = false, bool isShowAds = true, bool isTestAds = false}) {
    showAds = isShowAds;
    testAds = isTestAds;
    if (!showAds) return debugPrint('Ads are not shown');
    debugPrint('Initializing Mobile Ads, showAds: $showAds, gRated: $gRated');
    MobileAds.instance.initialize();
    if (gRated) {
      final RequestConfiguration requestConfiguration = RequestConfiguration(
          tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes);
      MobileAds.instance.updateRequestConfiguration(requestConfiguration);
      debugPrint('Initialized Mobile Ads for G-Rated');
      return;
    }
    debugPrint('Initialized Mobile Ads not for G-Rated');
  }
}
