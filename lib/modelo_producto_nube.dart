import 'package:cloud_firestore/cloud_firestore.dart';

class ProductoNube {
  final String id;
  final String nombre;
  final int precio;
  final bool disponible;

  const ProductoNube({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.disponible,
  });

  // Firestore guarda bool tal cual: no hay conversión a 0 o 1
  factory ProductoNube.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return ProductoNube(
      id: doc.id,
      nombre: d['nombre'] as String,
      precio: d['precio'] as int,
      disponible: d['disponible'] as bool,
    );
  }
}
