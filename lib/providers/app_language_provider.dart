import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  // data
  String appLanguage = 'ar';

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}
