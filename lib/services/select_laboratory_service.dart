import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/select_laboratory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectLaboratoryService extends ChangeNotifier {
  List<SelectLaboratory> selectLaboratories = [];

  SelectLaboratoryService() {
    getLaboratories();
  }

  Future getLaboratories() async {
    final url = Uri.parse('${API.BASE_URL}aulas');
    final response = await http.get(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['aulas'];
      selectLaboratories.clear();
      jsonData.forEach((json) {
        selectLaboratories.add(
          SelectLaboratory(
            value: json['id'],
            laboratory: json['nombre'],
          ),
        );
      });
      notifyListeners();
    } else {
      print(response.body);
    }
  }
}
