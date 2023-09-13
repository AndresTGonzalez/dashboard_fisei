import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/laboratory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LaboratoriesService extends ChangeNotifier {
  List<Aula> laboratories = [];
  List<Aula> searchsLaboratories = [];

  bool isLoading = true;

  LaboratoriesService() {
    getLaboratories();
  }

  Future getLaboratories() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}aulas');
    final response = await http.get(url);
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

  void search(String query) {
    searchsLaboratories = laboratories
        .where((subject) =>
            subject.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
