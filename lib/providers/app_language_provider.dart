import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  AppLanguageProvider() {
    getLanguage();
  }
  // data
  String appLanguage = 'en';

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    saveLanguage();
    notifyListeners();
  }

  Future<void> saveLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", appLanguage);
  }

  Future<void> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString("language") ?? "en";
  }
}
