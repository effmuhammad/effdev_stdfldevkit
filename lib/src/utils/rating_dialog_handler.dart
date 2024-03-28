import './sp_handler.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RatingDialogHandler {
  static Future<void> _saveLastRatingDialogDatetime() async {
    await SPHandler.saveString(
        'lastRatingDialogDatetime', DateTime.now().toString());
  }

  static Future<String?> _loadLastRatingDialogDatetime() async {
    return await SPHandler.getString('lastRatingDialogDatetime');
  }

  static Future<void> show(context, String imagePath) async {
    bool isShow = true;

    try {
      final lastRatingDialogDatetime =
          await _loadLastRatingDialogDatetime().then((value) async {
        if (value == null) {
          await _saveLastRatingDialogDatetime();
          return DateTime.now();
        } else {
          return DateTime.parse(value);
        }
      });

      isShow =
          DateTime.now().difference(lastRatingDialogDatetime).inSeconds > 1;
    } catch (e) {
      debugPrint(e.toString());
    }

    if (!isShow) {
      debugPrint('Belum waktunya munculkan rating dialog.');
      return;
    }

    _saveLastRatingDialogDatetime();

    final dialog = RatingDialog(
      initialRating: 0.0,
      // your app's name?
      title: const Text(
        'Beri kami nilai',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: const Text(
        'Gimana menurutmu aplikasi ini?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      image: Image.asset(
        imagePath,
        height: 150,
      ),
      submitButtonText: 'Kirim',
      commentHint: 'Tulis komentar disini...',
      onCancelled: () => debugPrint('cancelled'),
      onSubmitted: (response) {
        debugPrint('rating: ${response.rating}, comment: ${response.comment}');
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          // _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    return showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => dialog,
    );
  }
}
