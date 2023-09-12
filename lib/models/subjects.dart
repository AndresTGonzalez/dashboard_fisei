class Materia {
  int id;
  String nombre;
  String nivel;
  String numeroNivel;
  String carrera;
  DateTime createdAt;
  DateTime updatedAt;

  Materia({
    required this.id,
    required this.nombre,
    required this.nivel,
    required this.numeroNivel,
    required this.carrera,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      id: json['id'],
      nombre: json['nombre'],
      nivel: json['nivel'],
      numeroNivel: json['numero_nivel'],
      carrera: json['carrera'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
