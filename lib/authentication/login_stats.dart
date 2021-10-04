import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// create change notifier to rebuild widgets when the login status changes
class LoginStatus extends ChangeNotifier {
  bool userLoggedin = false;

  User? _user;
  User? get user => _user;

  LoginStatus() {
    _noticeChanges();
  }

  Future<void> _noticeChanges() async {
    // Listen to changes in user status (logged in or not)
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _user = user;
      } else {
        _user = null;
      }
      notifyListeners();
    });
  }
}
