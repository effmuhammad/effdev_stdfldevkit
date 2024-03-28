import 'dart:async';

import 'package:buku_sekolah/core/utils/google_mobile_ads_utils/init_mobile_ads.dart';
import 'package:buku_sekolah/customs/customs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardAdHandler {
  static RewardedAd? rewardAd;

  static var adCompleter = Completer<void>();

  static void load() {
    if (!InitMobileAds.showAds) return;

    if (rewardAd == null) {
      adCompleter = Completer<void>();
      RewardedAd.load(
        adUnitId: Customs.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            rewardAd = ad;
            adCompleter.complete();
          },
          onAdFailedToLoad: (error) {
            adCompleter.completeError(error);
            debugPrint('Failed to load a rewarded ad: ${error.message}');
            dispose();
          },
        ),
      );
    }
  }

  static Future<void> connectionWarning(
    BuildContext context,
    String title,
    String content,
  ) async {
    if (!InitMobileAds.showAds) return;
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 160,
            child: Column(
              children: [
                const Icon(
                  Icons.signal_wifi_connected_no_internet_4_rounded,
                  size: 100,
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> show(
    context, {
    required Function() onEarnedReward,
    String noConnectionTitle = "Tidak ada koneksi internet",
    String noConnectionContent =
        "Harap periksa koneksi internet Kamu dan coba lagi.",
  }) async {
    if (!InitMobileAds.showAds) return false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      if (rewardAd != null) {
        rewardAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) {},
          onAdDismissedFullScreenContent: (ad) {
            dispose();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint('Failed to show a full-screen ad: ${error.message}');
            dispose();
          },
        );

        rewardAd!.show(onUserEarnedReward: (ad, reward) {
          debugPrint('User earned reward of: ${reward.amount}');
          onEarnedReward();
        });
        return true;
      } else {
        load();
        return false;
      }
    } else {
      if (!InitMobileAds.showAds) return false;
      await connectionWarning(context, noConnectionTitle, noConnectionContent);
      return false;
    }
  }

  static void dispose() {
    if (!InitMobileAds.showAds) return;
    rewardAd?.dispose();
    rewardAd = null;
  }
}
