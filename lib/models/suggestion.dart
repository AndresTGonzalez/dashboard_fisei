class Sugerencia {
  int id;
  String nombre;
  String descripcion;
  String aula;

  Sugerencia({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.aula,
  });

  factory Sugerencia.fromJson(Map<String, dynamic> json) {
    return Sugerencia(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      aula: json['aula'],
    );
  }
}
