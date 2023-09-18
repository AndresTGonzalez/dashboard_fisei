import 'package:dashboard_fisei/utils/generate_controll_sheet.dart';
import 'package:flutter/material.dart';

class IndividualSheetProvider extends ChangeNotifier {
  String _carrera = '';
  String _docente = '';
  String _laboratorio = '';
  String _auxiliar = '';
  String _periodo = 'Septiembre 2023-Febrero 2024';
  String _nivel = '';
  String _paralelo = '';
  String _ingreso = '';
  String _salida = '';
  String _materia = '';

  String get carrera => _carrera;
  String get docente => _docente;
  String get laboratorio => _laboratorio;
  String get auxiliar => _auxiliar;
  String get periodo => _periodo;
  String get nivel => _nivel;
  String get paralelo => _paralelo;
  String get ingreso => _ingreso;
  String get salida => _salida;
  String get materia => _materia;

  set carrera(String carrera) {
    _carrera = carrera;
    notifyListeners();
  }

  set docente(String docente) {
    _docente = docente;
    notifyListeners();
  }

  set laboratorio(String laboratorio) {
    _laboratorio = laboratorio;
    notifyListeners();
  }

  set auxiliar(String auxiliar) {
    _auxiliar = auxiliar;
    notifyListeners();
  }

  set periodo(String periodo) {
    _periodo = periodo;
    notifyListeners();
  }

  set nivel(String nivel) {
    _nivel = nivel;
    notifyListeners();
  }

  set paralelo(String paralelo) {
    _paralelo = paralelo;
    notifyListeners();
  }

  set ingreso(String ingreso) {
    _ingreso = ingreso;
    notifyListeners();
  }

  set salida(String salida) {
    _salida = salida;
    notifyListeners();
  }

  set materia(String materia) {
    _materia = materia;
    notifyListeners();
  }

  Future generateSheet() async {
    // print('Carrera: $_carrera');
    // print('Docente: $_docente');
    // print('Auxiliar: $_auxiliar');
    // print('Periodo: $_periodo');
    // print('Nivel: $_nivel');
    // print('Paralelo: $_paralelo');
    // print('Ingreso: $_ingreso');
    // print('Salida: $_salida');
    // print('Materia: $_materia');
    GenerateControllSheet.generateControllSheet(
      carrera: _carrera,
      docente: _docente,
      laboratorio: _laboratorio,
      auxiliar: _auxiliar,
      periodo: _periodo,
      nivel: '$_nivel $_paralelo',
      ingreso: _ingreso,
      salida: _salida,
      materia: _materia,
    );
  }
}
