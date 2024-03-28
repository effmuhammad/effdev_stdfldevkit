import 'dart:async';

import 'package:buku_sekolah/core/utils/google_mobile_ads_utils/init_mobile_ads.dart';
import 'package:buku_sekolah/customs/customs.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHandler {
  static InterstitialAd? interstitialAd;

  static var adCompleter = Completer<void>();

  static Timer? loadTimer;
  static Timer? showTimer;
  static bool isShow = true;

  static void periodicTimer({required loadPeriod, required showPeriod}) async {
    if (!InitMobileAds.showAds) return;
    load();
    loadTimer = Timer.periodic(Duration(minutes: loadPeriod), (timer) {
      load();
    });
    showTimer = Timer.periodic(Duration(minutes: showPeriod), (timer) {
      isShow = true;
    });
  }

  static void cancelPeriodicTimer() {
    loadTimer?.cancel();
    showTimer?.cancel();
  }

  static void load() {
    if (!InitMobileAds.showAds) return;
    if (interstitialAd == null) {
      adCompleter = Completer<void>();

      InterstitialAd.load(
        adUnitId: Customs.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            adCompleter.complete();
          },
          onAdFailedToLoad: (error) {
            adCompleter.completeError(error);
            debugPrint('Failed to load an interstitial ad: ${error.message}');
            dispose();
          },
        ),
      );
    }
  }

  static bool show() {
    if (!InitMobileAds.showAds) return false;
    if (interstitialAd != null && isShow) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdDismissedFullScreenContent: (ad) {
          dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          dispose();
        },
      );

      interstitialAd!.show();
      isShow = false;
      return true;
    } else {
      return false;
    }
  }

  static void dispose() {
    if (!InitMobileAds.showAds) return;
    interstitialAd?.dispose();
    interstitialAd = null;
    isShow = false;
  }
}
