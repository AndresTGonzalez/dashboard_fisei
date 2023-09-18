class Horario {
  final String laboratorio;
  final String docente;
  final String nivel;
  final String carrera;
  final String materia;
  final String inicio;
  final String fin;
  final String fecha;

  Horario({
    required this.laboratorio,
    required this.docente,
    required this.nivel,
    required this.carrera,
    required this.materia,
    required this.inicio,
    required this.fin,
    required this.fecha,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      laboratorio: json['laboratorio'],
      docente: json['docente'],
      nivel: json['nivel'],
      carrera: json['carrera'],
      materia: json['materia'],
      inicio: json['inicio'],
      fin: json['fin'],
      fecha: json['fecha'],
    );
  }
}
