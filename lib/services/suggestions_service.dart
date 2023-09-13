import 'dart:convert';

import 'package:dashboard_fisei/constants/constants.dart';
import 'package:dashboard_fisei/models/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuggestionsService extends ChangeNotifier {
  List<Sugerencia> suggestions = [];
  List<Sugerencia> searchsuggestions = [];

  bool isLoading = true;

  SuggestionsService() {
    getSuggestions();
  }

  Future getSuggestions() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}sugerencias');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['sugerencias'];
      suggestions = jsonData.map((json) => Sugerencia.fromJson(json)).toList();
      searchsuggestions = suggestions;
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      // print(response.body);
    }
  }

  void search(String query) {
    searchsuggestions = suggestions
        .where((suggestion) =>
            suggestion.aula.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
