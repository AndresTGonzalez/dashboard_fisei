import 'package:dashboard_fisei/models/teacher.dart';
import 'package:flutter/material.dart';

class TeachersService extends ChangeNotifier {
  List<Teacher> teachers = [
    Teacher(identification: 1, name: 'John Doe'),
    Teacher(identification: 2, name: 'Jane Smith'),
    Teacher(identification: 3, name: 'Bob Johnson'),
    Teacher(identification: 4, name: 'Alice Brown'),
    Teacher(identification: 5, name: 'Chris Wilson'),
    Teacher(identification: 6, name: 'Emily Davis'),
    Teacher(identification: 7, name: 'David Lee'),
    Teacher(identification: 8, name: 'Laura Taylor'),
    Teacher(identification: 9, name: 'Michael Anderson'),
    Teacher(identification: 10, name: 'Sarah Clark'),
    Teacher(identification: 11, name: 'Kevin White'),
    Teacher(identification: 12, name: 'Lisa Martinez'),
    Teacher(identification: 13, name: 'Brian Thomas'),
    Teacher(identification: 14, name: 'Jessica Hall'),
    Teacher(identification: 15, name: 'Matthew Allen'),
    Teacher(identification: 16, name: 'Elizabeth King'),
    Teacher(identification: 17, name: 'Daniel Turner'),
    Teacher(identification: 18, name: 'Jennifer Scott'),
    Teacher(identification: 19, name: 'Robert Adams'),
    Teacher(identification: 20, name: 'Karen Hernandez'),
    Teacher(identification: 21, name: 'William Perez'),
    Teacher(identification: 22, name: 'Patricia Nelson'),
    Teacher(identification: 23, name: 'Joseph Thomas'),
    Teacher(identification: 24, name: 'Nancy Lewis'),
    Teacher(identification: 25, name: 'Anthony Young'),
    Teacher(identification: 26, name: 'Cynthia Johnson'),
    Teacher(identification: 27, name: 'Christopher Moore'),
    Teacher(identification: 28, name: 'Angela Turner'),
    Teacher(identification: 29, name: 'David Miller'),
    Teacher(identification: 30, name: 'Maria Martin'),
  ];

  List<Teacher> searchTeachers = [];

  TeachersService() {
    searchTeachers = teachers;
  }

  void search(String query) {
    searchTeachers = teachers
        .where((teacher) =>
            teacher.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
