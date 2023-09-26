import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LaboratoriesService extends ChangeNotifier {
  List<Aula> laboratories = [];
  List<Aula> searchsLaboratories = [];

  String nombre = '';
  String nivel = 'Nivelacion';
  int idCarrera = 1;
  int cantidadPc = 0;
  int capacidad = 0;
  String aireAcondicionado = 'No';
  String proyector = 'No';

  String piso = '1';
  String edificio = 'Bloque 1';

  bool isLoading = true;

  LaboratoriesService() {
    getLaboratories();
  }

  Future getLaboratories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}aulas');
    final response = await http.get(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['aulas'];
      laboratories = jsonData.map((json) => Aula.fromJson(json)).toList();
      searchsLaboratories = laboratories;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      // print(response.body);
    }
  }

  Future<bool> addLaboratory(Aula aula) async {
    try {
      isLoading = true;
      notifyListeners();
      final url = Uri.parse('${API.BASE_URL}aulas');
      final response = await http.post(
        url,
        headers: API.defaultHeaders,
        body: jsonEncode(
          {
            'nombre': aula.nombre!.toUpperCase(),
            'edificio': aula.edificio!,
            'piso': aula.piso!,
            'proyector': aula.proyector!,
            'aire': aula.aire!,
            'cantidad_pc': aula.cantidadPc,
            'capacidad': aula.capacidad,
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        laboratories.add(Aula.fromJson(jsonData));
        searchsLaboratories = laboratories;
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateLaboratory(Aula aula) async {
    try {
      final url = Uri.parse('${API.BASE_URL}aulas/${aula.id}');
      final response = await http.put(
        url,
        headers: API.defaultHeaders,
        body: jsonEncode(
          {
            "nombre": aula.nombre,
            "edificio": aula.edificio,
            "piso": aula.piso,
            "proyector": aula.proyector,
            "aire": aula.aire,
            "cantidad_pc": aula.cantidadPc,
            "capacidad": aula.capacidad,
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final index =
            laboratories.indexWhere((element) => element.id == aula.id);
        laboratories[index] = Aula.fromJson(jsonData);
        searchsLaboratories = laboratories;
        notifyListeners();
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future deleteLaboratory(int id) async {
    final url = Uri.parse('${API.BASE_URL}aulas/$id');
    final response = await http.delete(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      laboratories.removeWhere((element) => element.id == id);
      searchsLaboratories = laboratories;
      notifyListeners();
    } else {}
  }

  void search(String query) {
    searchsLaboratories = laboratories
        .where((subject) =>
            subject.nombre!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
