import 'package:event_planning/model/myUser.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // data
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
