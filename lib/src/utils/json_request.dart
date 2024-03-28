import 'dart:convert';
import 'package:flutter/services.dart';

class JsonRequest {
  static Future<Map<String, dynamic>> loadData(String assetPath) async {
    String jsonString = await rootBundle.loadString(assetPath);
    return json.decode(jsonString);
  }
}
