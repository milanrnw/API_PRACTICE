import 'package:api_practice/presentation/login_screen.dart';
import 'package:api_practice/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class AuthService {
  AuthService._();

  static Future<void> logoutUser(BuildContext context) async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (val) => false);
    await SharedPrefs.clearAll();
  }
}
