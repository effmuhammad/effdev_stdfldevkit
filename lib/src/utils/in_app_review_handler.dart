import 'dart:async';

import 'package:advanced_in_app_review/advanced_in_app_review.dart';
import 'package:in_app_review/in_app_review.dart';

// // Advance In App Review Configuration
// // In your app’s build.gradle file:
// ...
// dependencies {
//     // This dependency is downloaded from the Google’s Maven repository.
//     // So, make sure you also include that repository in your project's build.gradle file.
//     implementation 'com.google.android.play:review:2.0.1'
//     // For Kotlin users also add the Kotlin extensions library for Play In-App Review:
//     implementation 'com.google.android.play:review-ktx:2.0.1'
//     ...
// }

class InAppReviewHandler {
  static Future<void> requestReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      Future.delayed(const Duration(seconds: 2), () {
        inAppReview.requestReview();
      });
    }
  }

  static void advanceInAppReview() {
    AdvancedInAppReview()
        .setMinDaysBeforeRemind(7)
        .setMinDaysAfterInstall(2)
        .setMinLaunchTimes(2)
        .setMinSecondsBeforeShowDialog(10)
        .monitor();
  }

  static Future<void> openStoreListing() async {
    final InAppReview inAppReview = InAppReview.instance;
    await inAppReview.openStoreListing();
  }
}
