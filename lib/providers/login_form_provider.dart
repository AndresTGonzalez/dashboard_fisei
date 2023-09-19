import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';

  // Getters
  String get email {
    return _email;
  }

  String get password {
    return _password;
  }

  // Setters
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }
}
