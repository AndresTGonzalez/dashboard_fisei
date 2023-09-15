import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/select_subject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectSubjectService extends ChangeNotifier {
  List<SelectSubject> selectSubjects = [];

  SelectSubjectService() {
    // getSubjects();
  }

  Future getSubjects(int id) async {
    final url = Uri.parse('${API.BASE_URL}carrera/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['materias'];
      selectSubjects.clear();
      jsonData.forEach((json) {
        selectSubjects.add(
          SelectSubject(
            value: json['id'],
            subject: json['nombre'],
          ),
        );
      });
      print(selectSubjects.length);
      notifyListeners();
    } else {
      print(response.body);
    }
  }
}