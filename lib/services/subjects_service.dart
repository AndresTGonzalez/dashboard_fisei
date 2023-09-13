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

  Future getSubjects() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}actividades');
    final response = await http.get(url);
    print(response.body);
    // if (response.statusCode == 200) {
    //   final List<dynamic> jsonData = jsonDecode(response.body)['actividades'];
    //   subjects = jsonData.map((json) => Materia.fromJson(json)).toList();
    //   searchsSubjects = subjects;
    //   isLoading = false;
    //   notifyListeners();
    // } else {
    //   isLoading = false;
    //   notifyListeners();
    //   // print(response.body);
    // }
  }

  Future addSubject(Materia materia) async {
    final url = Uri.parse('${API.BASE_URL}actividades');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'nombre': materia.nombre,
          'nivel': materia.nivel,
          'carrera': materia.carrera,
          'id_carrera': materia.idCarrera,
        },
      ),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      // subjects.add(Materia.fromJson(jsonData));
      Materia mat = Materia.fromJson(jsonData);
      // searchsSubjects = subjects;
      // notifyListeners();
    } else {
      print(response.body);
    }
    // print(materia.nombre);
  }

  void search(String query) {
    searchsSubjects = subjects
        .where((subject) =>
            subject.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
