import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/sheet.dart';
import 'package:dashboard_fisei/utils/generate_controll_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlSheetProvider extends ChangeNotifier {
  int _blok = 0;
  String _manana = '';
  String _tarde = '';

  List<Horario> horarios = [];

  int get blok => _blok;
  String get manana => _manana;
  String get tarde => _tarde;

  set blok(int value) {
    _blok = value;
    notifyListeners();
  }

  set manana(String value) {
    _manana = value;
    notifyListeners();
  }

  set tarde(String value) {
    _tarde = value;
    notifyListeners();
  }

  Future getSchedules({
    int blok = 0,
  }) async {
    DateTime now = DateTime.now();
    final url = Uri.parse('${API.BASE_URL}horario/$blok/${now.weekday}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['horarios'];
      horarios = jsonData.map((json) => Horario.fromJson(json)).toList();
      _sortSchedules();
      await GenerateControllSheet.generateBlock(
        horarios: horarios,
        manana: manana,
        tarde: tarde,
      );
    } else {
      // print(response.body);
    }
  }

  // Ordenar horarios primero por laboratorio
  void _sortSchedules() {
    horarios.sort((a, b) {
      if (a.laboratorio == b.laboratorio) {
        return a.inicio.compareTo(b.inicio);
      } else {
        return a.laboratorio.compareTo(b.laboratorio);
      }
    });
  }
}
