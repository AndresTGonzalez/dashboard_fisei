class Caracteristica {
  final int id;
  final String nombre;
  final String descripcion;

  Caracteristica({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Caracteristica.fromJson(Map<String, dynamic> json) {
    return Caracteristica(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }
}

class Software {
  final int id;
  final String nombre;
  final String version;
  final String createdAt;
  final String updatedAt;

  Software({
    required this.id,
    required this.nombre,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      id: json['id'],
      nombre: json['nombre'],
      version: json['version'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Aula {
  final int id;
  final String nombre;
  final String edificio;
  final int numeroEdificio;
  final String piso;
  final int numeroPiso;
  final bool? proyector;
  final bool? aire;
  final int cantidadPc;
  final int capacidad;
  final String createdAt;
  final String updatedAt;
  final List<Caracteristica> caracteristicas;
  final List<Software> softwares;

  Aula({
    required this.id,
    required this.nombre,
    required this.edificio,
    required this.numeroEdificio,
    required this.piso,
    required this.numeroPiso,
    this.proyector,
    this.aire,
    required this.cantidadPc,
    required this.capacidad,
    required this.createdAt,
    required this.updatedAt,
    required this.caracteristicas,
    required this.softwares,
  });

  factory Aula.fromJson(Map<String, dynamic> json) {
    List<dynamic> caracteristicasJson = json['caracteristicas'] ?? [];
    List<dynamic> softwaresJson = json['softwares'] ?? [];

    return Aula(
      id: json['id'],
      nombre: json['nombre'],
      edificio: json['edificio'],
      numeroEdificio: json['numero_edificio'],
      piso: json['piso'],
      numeroPiso: json['numero_piso'],
      proyector: json['proyector'],
      aire: json['aire'],
      cantidadPc: json['cantidad_pc'],
      capacidad: json['capacidad'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      caracteristicas: caracteristicasJson
          .map((caracteristica) => Caracteristica.fromJson(caracteristica))
          .toList(),
      softwares:
          softwaresJson.map((software) => Software.fromJson(software)).toList(),
    );
  }
}
