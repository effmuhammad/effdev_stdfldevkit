import 'package:flutter/material.dart';

class Navigate {
  static Future<void> to(BuildContext context, String route) async {
    await Future.delayed(const Duration(milliseconds: 100), () async {
      await Navigator.pushNamed(context, route);
    });
  }

  static Future<void> pop(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      Navigator.pop(context);
    });
  }
}
