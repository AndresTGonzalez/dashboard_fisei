import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SchedulesService extends ChangeNotifier {
  List<HorarioInfo> schedules = [];

  bool isLoading = false;

  // Ordenar los horarios por dia luego por hora de inicio
  void sortSchedules() {
    schedules.sort((a, b) {
      if (a.diaSemana == b.diaSemana) {
        return a.horaInicio.compareTo(b.horaInicio);
      } else {
        return a.diaSemana.compareTo(b.diaSemana);
      }
    });
    notifyListeners();
  }

  Future getSchedulesByTeacher(int id) async {
    isLoading = true;
    notifyListeners();
    schedules.clear();
    print('getSchedulesByTeacher');
    final url = Uri.parse('${API.BASE_URL}docente/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final schedulesData = data['horarioInfo'];
      schedulesData.forEach((schedule) {
        final scheduleTemp = HorarioInfo.fromJson(schedule);
        schedules.add(scheduleTemp);
      });
      sortSchedules();
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      print('Error');
    }
  }
}
