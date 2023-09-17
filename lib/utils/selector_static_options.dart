import 'package:dashboard_fisei/models/select_carrer.dart';
import 'package:dashboard_fisei/models/select_day.dart';
import 'package:dashboard_fisei/models/select_hour.dart';
import 'package:dashboard_fisei/models/select_nivel.dart';
import 'package:dashboard_fisei/models/select_parallel.dart';

class SelectorStaticOptions {
  static List<SelectDay> days = [
    SelectDay(value: 1, day: 'Lunes'),
    SelectDay(value: 2, day: 'Martes'),
    SelectDay(value: 3, day: 'Miercoles'),
    SelectDay(value: 4, day: 'Jueves'),
    SelectDay(value: 5, day: 'Viernes'),
    SelectDay(value: 6, day: 'Sabado'),
  ];

  static List<SelectHour> hours = [
    SelectHour(value: '7', hour: '07H00'),
    SelectHour(value: '8', hour: '08H00'),
    SelectHour(value: '9', hour: '09H00'),
    SelectHour(value: '10', hour: '10H00'),
    SelectHour(value: '11', hour: '11H00'),
    SelectHour(value: '12', hour: '12H00'),
    SelectHour(value: '13', hour: '13H00'),
    SelectHour(value: '14', hour: '14H00'),
    SelectHour(value: '15', hour: '15H00'),
    SelectHour(value: '16', hour: '16H00'),
    SelectHour(value: '17', hour: '17H00'),
    SelectHour(value: '18', hour: '18H00'),
    SelectHour(value: '19', hour: '19H00'),
    SelectHour(value: '20', hour: '20H00'),
    SelectHour(value: '21', hour: '21H00')
  ];

  static List<SelectParallel> parallels = [
    SelectParallel(value: 1, parallel: 'A'),
    SelectParallel(value: 2, parallel: 'B'),
    SelectParallel(value: 3, parallel: 'C'),
    SelectParallel(value: 4, parallel: 'D'),
  ];

  static List<SelectCarrer> carreras = [
    SelectCarrer(id: 1, carrera: 'Software'),
    SelectCarrer(id: 2, carrera: 'Electrónica y Telecomunicaciones'),
    SelectCarrer(id: 3, carrera: 'Ingeniería Industrial'),
    SelectCarrer(id: 4, carrera: 'Robótica'),
    SelectCarrer(id: 5, carrera: 'Tecnologías de la Información'),
  ];

  static List<SelectCarrer> carrersSheet = [
    SelectCarrer(id: 1, carrera: 'Software'),
    SelectCarrer(id: 2, carrera: 'Tecnologías de la Información'),
    SelectCarrer(id: 3, carrera: 'Ingeniería Industrial'),
    SelectCarrer(id: 4, carrera: 'Electrónica y Telecomunicaciones'),
    SelectCarrer(id: 5, carrera: 'Robótica'),
  ];

  static List<SelectNivel> niveles = [
    SelectNivel(value: 'Nivelacion', nivel: 'Nivelación'),
    SelectNivel(value: 'Primero', nivel: 'Primero'),
    SelectNivel(value: 'Segundo', nivel: 'Segundo'),
    SelectNivel(value: 'Tercero', nivel: 'Tercero'),
    SelectNivel(value: 'Cuarto', nivel: 'Cuarto'),
    SelectNivel(value: 'Quinto', nivel: 'Quinto'),
    SelectNivel(value: 'Sexto', nivel: 'Sexto'),
    SelectNivel(value: 'Septimo', nivel: 'Septimo'),
    SelectNivel(value: 'Octavo', nivel: 'Octavo'),
    SelectNivel(value: 'Noveno', nivel: 'Noveno'),
    SelectNivel(value: 'Decimo', nivel: 'Decimo'),
  ];

  static List<String> meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
}
