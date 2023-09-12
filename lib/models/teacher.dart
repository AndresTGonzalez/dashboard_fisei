class Teacher {
  int id;
  String nombre;
  String cedula;

  Teacher({
    required this.id,
    required this.nombre,
    required this.cedula,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      nombre: json['nombre'],
      cedula: json['cedula'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cedula': cedula,
    };
  }
}
