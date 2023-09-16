import 'package:flutter/material.dart';

class SoftwareService extends ChangeNotifier {
  String _nombre = '';
  String _version = '';

  String get nombre => _nombre;
  String get version => _version;

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set version(String value) {
    _version = value;
    notifyListeners();
  }
}
