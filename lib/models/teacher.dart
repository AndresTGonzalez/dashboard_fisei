class Teacher {
  final int identification;
  final String name;

  Teacher({required this.identification, required this.name});

  // Método para convertir un mapa en una instancia de Teacher
  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      identification: map['identification'] as int,
      name: map['name'] as String,
    );
  }

  // Método para convertir una instancia de Teacher en un mapa
  Map<String, dynamic> toMap() {
    return {
      'identification': identification,
      'name': name,
    };
  }
}
