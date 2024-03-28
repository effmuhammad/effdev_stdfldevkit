import 'package:flutter/material.dart';

class ResultInfo {
  static String response(double score) {
    if (score >= 90) {
      return "Selamat! Hasil belajarmu bernilai sangat baik.";
    } else if (score >= 80) {
      return "Selamat! Hasil belajarmu bernilai baik.";
    } else if (score >= 70) {
      return "Selamat! Hasil belajarmu bernilai cukup.";
    } else {
      return "Hasil belajarmu bernilai kurang. Kamu bisa coba lagi.";
    }
  }

  static MaterialColor color(double score) {
    if (score >= 90) {
      return Colors.green;
    } else if (score >= 80) {
      return Colors.green;
    } else if (score >= 70) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
