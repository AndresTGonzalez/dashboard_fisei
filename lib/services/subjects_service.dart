import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/subjects.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubjectsService extends ChangeNotifier {
  List<Materia> subjects = [];
  List<Materia> searchsSubjects = [];

  String nombre = '';
  String nivel = 'Nivelacion';
  int idCarrera = 1;

  bool isLoading = true;

  SubjectsService() {
    getSubjects();
  }

  Future<bool> getSubjects() async {
    try {
      isLoading = true;
      notifyListeners();
      final url = Uri.parse('${API.BASE_URL}actividades');
      final response = await http.get(
        url,
        headers: API.defaultHeaders,
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body)['actividades'];
        subjects = jsonData.map((json) => Materia.fromJson(json)).toList();
        searchsSubjects = subjects;
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> addSubject(Materia materia) async {
    try {
      final url = Uri.parse('${API.BASE_URL}actividades');
      final response = await http.post(
        url,
        headers: API.defaultHeaders,
        body: jsonEncode(
          {
            'nombre': materia.nombre.toUpperCase(),
            'nivel': materia.nivel,
            'id_carrera': materia.idCarrera,
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var nombre = jsonData['nombre'];
        var nivel = jsonData['nivel'];
        var idCarrera = jsonData['id_carrera'];
        var carrera = jsonData['carrera'];
        var id = jsonData['id'];
        subjects.add(Materia(
          id: id,
          nombre: nombre,
          nivel: nivel,
          idCarrera: idCarrera,
          carrera: carrera,
        ));
        searchsSubjects = subjects;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSubject(Materia materia) async {
    try {
      final url = Uri.parse('${API.BASE_URL}actividades/${materia.id}');
      final response = await http.put(
        url,
        headers: API.defaultHeaders,
        body: jsonEncode(
          {
            'nombre': materia.nombre.toUpperCase(),
            'nivel': materia.nivel,
            'id_carrera': materia.idCarrera,
          },
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var nombre = jsonData['nombre'];
        var nivel = jsonData['nivel'];
        var idCarrera = jsonData['id_carrera'];
        var carrera = jsonData['carrera'];
        var id = jsonData['id'];
        subjects = subjects.map((subject) {
          if (subject.id == materia.id) {
            subject = Materia(
              id: id,
              nombre: nombre,
              nivel: nivel,
              idCarrera: idCarrera,
              carrera: carrera,
            );
          }
          return subject;
        }).toList();
        searchsSubjects = subjects;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future deleteSubject(int id) async {
    final url = Uri.parse('${API.BASE_URL}actividades/$id');
    final response = await http.delete(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      subjects.removeWhere((subject) => subject.id == id);
      searchsSubjects = subjects;
      notifyListeners();
    } else {}
  }

  void search(String query) {
    //Buscar por nombre y por carrera
    searchsSubjects = subjects
        .where((subject) =>
            subject.nombre.toLowerCase().contains(query.toLowerCase()) ||
            subject.carrera!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
