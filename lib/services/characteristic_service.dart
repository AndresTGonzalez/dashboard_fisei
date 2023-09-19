import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CharacteristicService extends ChangeNotifier {
  final List<Caracteristica> caracteristicas;

  String _nombre = '';
  String _descripcion = '';
  int _laboratoryId = 0;

  CharacteristicService({required this.caracteristicas});

  String get nombre => _nombre;
  String get descripcion => _descripcion;
  int get laboratoryId => _laboratoryId;

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set descripcion(String value) {
    _descripcion = value;
    notifyListeners();
  }

  set laboratoryId(int value) {
    _laboratoryId = value;
    notifyListeners();
  }

  Future<bool> addCharacteristic({
    int? laboratoryId,
  }) async {
    try {
      final url = Uri.parse('${API.BASE_URL}caracteristicas');
      final response = await http.post(
        url,
        headers: API.defaultHeaders,
        body: jsonEncode({
          'nombre': nombre,
          'descripcion': descripcion,
          'aula_id': laboratoryId.toString(),
        }),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        caracteristicas.add(Caracteristica.fromJson(jsonData));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCharacteristic({
    required int characteristicId,
  }) async {
    try {
      final url = Uri.parse('${API.BASE_URL}caracteristicas/$characteristicId');
      final response = await http.put(
        url,
        headers: API.defaultHeaders,
        body: jsonEncode({
          'nombre': nombre,
          'descripcion': descripcion,
        }),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final index = caracteristicas.indexWhere(
          (caracteristica) => caracteristica.id == characteristicId,
        );
        caracteristicas[index] = Caracteristica.fromJson(jsonData);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future deleteCharacteristic({
    required int characteristicId,
  }) async {
    final url = Uri.parse('${API.BASE_URL}caracteristicas/$characteristicId');
    final response = await http.delete(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      caracteristicas.removeWhere(
        (caracteristica) => caracteristica.id == characteristicId,
      );
      notifyListeners();
    } else {}
  }
}
