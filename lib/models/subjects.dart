class Materia {
  int id;
  String nombre;
  String nivel;
  int? numeroNivel;
  String? carrera;
  int idCarrera;
  DateTime? createdAt;
  DateTime? updatedAt;

  Materia({
    required this.id,
    required this.nombre,
    required this.nivel,
    this.numeroNivel,
    this.carrera,
    required this.idCarrera,
    this.createdAt,
    this.updatedAt,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      id: json['id'],
      nombre: json['nombre'],
      nivel: json['nivel'],
      numeroNivel: json['numero_nivel'],
      carrera: json['carrera'],
      idCarrera: json['id_carrera'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
