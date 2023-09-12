import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeachersService extends ChangeNotifier {
  List<Teacher> teachers = [];
  List<Teacher> searchTeachers = [];

  bool isLoading = true;

  TeachersService() {
    // getTeachers();
  }

  Future getTeachers() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}docentes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['docentes'];
      teachers = jsonData.map((json) => Teacher.fromJson(json)).toList();
      searchTeachers = teachers;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      // print(response.body);
    }
  }

  void search(String query) {
    searchTeachers = teachers
        .where((teacher) =>
            teacher.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
