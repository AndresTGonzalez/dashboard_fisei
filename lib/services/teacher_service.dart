import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeachersService extends ChangeNotifier {
  List<Teacher> teachers = [];
  List<Teacher> searchTeachers = [];

  String cedula = '';
  String nombre = '';

  bool isLoading = true;

  TeachersService() {
    getTeachers();
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

  Future addTeacher(Teacher teacher) async {
    final url = Uri.parse('${API.BASE_URL}docentes');
    final response = await http.post(
      url,
      body: jsonEncode({
        'docente': teacher.nombre,
        'cedula': teacher.cedula,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      teachers.add(Teacher.fromJson(jsonData));
      searchTeachers = teachers;
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  Future editTeacher(Teacher teacher) async {
    // print(teacher.id);

    final url = Uri.parse('${API.BASE_URL}docentes/${teacher.id}');
    final response = await http.put(
      url,
      body: jsonEncode({
        'docente': teacher.nombre,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      teachers[teachers.indexWhere((element) => element.id == teacher.id)] =
          Teacher.fromJson(jsonData);
      searchTeachers = teachers;
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  Future deleteTeacher(int id) async {
    final url = Uri.parse('${API.BASE_URL}docentes/$id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      teachers.removeWhere((element) => element.id == id);
      searchTeachers = teachers;
      notifyListeners();
    } else {
      print(response.body);
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
