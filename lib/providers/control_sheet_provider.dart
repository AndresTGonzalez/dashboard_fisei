import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/sheet.dart';
import 'package:dashboard_fisei/utils/generate_controll_sheet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlSheetProvider extends ChangeNotifier {
  TextEditingController dateinput = TextEditingController();

  int _blok = 0;
  String _manana = '';
  String _tarde = '';
  DateTime _date = DateTime.now();

  List<Horario> horarios = [];

  int get blok => _blok;
  String get manana => _manana;
  DateTime get date => _date;
  String get tarde => _tarde;

  set blok(int value) {
    _blok = value;
    notifyListeners();
  }

  set date(DateTime value) {
    _date = value;
    dateinput.text = value.toString().substring(0, 10);
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

  ControlSheetProvider() {
    dateinput.text = DateTime.now().toString().substring(0, 10);
  }

  Future getSchedules({
    int blok = 0,
  }) async {
    try {
      final url = Uri.parse('${API.BASE_URL}horario/$blok/${_date.weekday}');
      final response = await http.get(
        url,
        headers: API.defaultHeaders,
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['horarios'];
        horarios = jsonData.map((json) => Horario.fromJson(json)).toList();
        _sortSchedules();
        await GenerateControllSheet.generateBlock(
          horarios: horarios,
          manana: manana,
          tarde: tarde,
          fecha: _date,
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
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
