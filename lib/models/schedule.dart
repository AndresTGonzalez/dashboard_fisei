class HorarioInfo {
  final int id;
  final String diaSemana;
  final int numeroDia;
  final String horaInicio;
  final String horaFin;
  final String aulaPuestoInfo;
  final bool aula;
  final bool puesto;
  final String actividad;
  final String nivel;
  final String carrera;
  final String paralelo;

  HorarioInfo({
    required this.id,
    required this.diaSemana,
    required this.numeroDia,
    required this.horaInicio,
    required this.horaFin,
    required this.aulaPuestoInfo,
    required this.aula,
    required this.puesto,
    required this.actividad,
    required this.nivel,
    required this.carrera,
    required this.paralelo,
  });

  factory HorarioInfo.fromJson(Map<String, dynamic> json) {
    return HorarioInfo(
      id: json['id'],
      diaSemana: json['dia_semana'],
      numeroDia: json['numero_dia'],
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
      aulaPuestoInfo: json['aula_puesto_info'],
      aula: json['aula'],
      puesto: json['puesto'],
      actividad: json['actividad'],
      nivel: json['nivel'],
      carrera: json['carrera'],
      paralelo: json['paralelo'],
    );
  }
}
