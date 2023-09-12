import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/subjects.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubjectsService extends ChangeNotifier {
  List<Materia> subjects = [];
  List<Materia> searchsSubjects = [];

  bool isLoading = true;

  SubjectsService() {
    getSubjects();
  }

  Future getSubjects() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}actividades');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['actividades'];
      subjects = jsonData.map((json) => Materia.fromJson(json)).toList();
      searchsSubjects = subjects;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      // print(response.body);
    }
  }

  void search(String query) {
    searchsSubjects = subjects
        .where((subject) =>
            subject.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
