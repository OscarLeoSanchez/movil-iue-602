class Producto {
  final int id;
  final String nombre;
  final int precio;
  final bool disponible;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.disponible,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'disponible': disponible ? 1 : 0,
    };
  }

  factory Producto.fromMap(Map<String, Object?> mapa) {
    return Producto(
      id: mapa['id'] as int,
      nombre: mapa['nombre'] as String,
      precio: mapa['precio'] as int,
      disponible: mapa['disponible'] == 1,
    );
  }

  // factory Producto.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final d = doc.data()!;
  //   return Producto(
  //     id: doc.id,
  //     nombre: d['nombre'] as String,
  //     precio: d['precio'] as int,
  //     disponible: d['disponible'] as bool,
  //   );
  // }
}
