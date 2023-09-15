import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectTeacherService extends ChangeNotifier {
  List<Teacher> teachers = [];

  SelectTeacherService() {
    getTeachers();
  }

  //Ordenar los docentes por orden alfabetico
  void sortTeachers() {
    teachers.sort((a, b) => a.nombre.compareTo(b.nombre));
    notifyListeners();
  }

  Future getTeachers() async {
    final url = Uri.parse('${API.BASE_URL}docentes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['docentes'];
      teachers = jsonData.map((json) => Teacher.fromJson(json)).toList();
      notifyListeners();
    } else {
      print(response.body);
    }
  }
}
