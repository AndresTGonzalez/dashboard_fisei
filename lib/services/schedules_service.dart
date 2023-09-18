import 'dart:convert';

import 'package:dashboard_fisei/constants/api.dart';
import 'package:dashboard_fisei/models/schedule.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SchedulesService extends ChangeNotifier {
  List<HorarioInfo> schedules = [];

  bool isLoading = false;

  int _selectedTeacherId = 0;
  bool _isPosition = false;

  int aulaId = 0;
  int docenteId = 0;
  int actividadId = 0;
  int paraleloId = 0;
  String horaInicio = '';
  String horaFin = '';
  String numeroPuesto = '';
  int numeroDia = 0;

  set selectedTeacherId(int value) {
    _selectedTeacherId = value;
    getSchedulesByTeacher(value);
    notifyListeners();
  }

  int get selectedTeacherId => _selectedTeacherId;

  set isPosition(bool value) {
    _isPosition = value;
    notifyListeners();
  }

  bool get isPosition => _isPosition;

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
    final url = Uri.parse('${API.BASE_URL}docente/$id');
    final response = await http.get(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final schedulesData = data['horarioInfo'];
      schedulesData.forEach((schedule) {
        final scheduleTemp = HorarioInfo.fromJson(schedule);
        schedules.add(scheduleTemp);
      });
      sortSchedules();
      isLoading = false;
      notifyListeners();
    } else {
      print('Error');
    }
  }

  Future deleteSchedule(int id) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}horarios/$id');
    final response = await http.delete(
      url,
      headers: API.defaultHeaders,
    );
    if (response.statusCode == 200) {
      schedules.removeWhere((schedule) => schedule.id == id);
      isLoading = false;
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  Future addSchedule({
    int? aulaId,
    int? docenteId,
    int? actividadId,
    int? paraleloId,
    String? horaInicio,
    String? horaFin,
    String numeroPuesto = '',
    int? numeroDia,
  }) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${API.BASE_URL}horarios');
    final response = await http.post(
      url,
      headers: API.defaultHeaders,
      body: jsonEncode(
        {
          'aula_id': aulaId,
          'docente_id': docenteId,
          'actividad_id': actividadId,
          'paralelo_id': paraleloId,
          'hora_inicio': horaInicio,
          'hora_fin': horaFin,
          'numero_puesto': numeroPuesto,
          'numero_dia': numeroDia,
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final scheduleTemp = HorarioInfo.fromJson(data);
      schedules.add(scheduleTemp);
      print(scheduleTemp.numeroDia);
      sortSchedules();
      isLoading = false;
      notifyListeners();
    } else {
      print(response.body);
    }
  }
}
