import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SoftwareService extends ChangeNotifier {
  final List<Software> softwares;

  String _nombre = '';
  String _version = '';
  int _laboratoryId = 0;

  SoftwareService({required this.softwares});

  String get nombre => _nombre;
  String get version => _version;
  int get laboratoryId => _laboratoryId;

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set version(String value) {
    _version = value;
    notifyListeners();
  }

  set laboratoryId(int value) {
    _laboratoryId = value;
    notifyListeners();
  }

  Future addSoftware({
    Software? software,
    int? laboratoryId,
  }) async {
    final url = Uri.parse('${API.BASE_URL}softwares');
    final response = await http.post(
      url,
      headers: API.defaultHeaders,
      body: {
        'nombre': nombre,
        'version': version,
        'aula_id': laboratoryId.toString(),
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      softwares.add(Software.fromJson(jsonData));
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  Future updateSoftware({
    required Software software,
    required int laboratoryId,
  }) async {
    final url = Uri.parse('${API.BASE_URL}softwares/${software.id}');
    final response = await http.put(
      url,
      headers: API.defaultHeaders,
      body: {
        'nombre': nombre,
        'version': version,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final index = softwares.indexWhere((s) => s.id == software.id);
      softwares[index] = Software.fromJson(jsonData);
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  Future deleteSoftware({
    required Software software,
  }) async {
    final url = Uri.parse('${API.BASE_URL}softwares/${software.id}');
    final response = await http.delete(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      softwares.removeWhere((s) => s.id == software.id);
      notifyListeners();
    } else {
      print(response.body);
    }
  }
}
