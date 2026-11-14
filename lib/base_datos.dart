import 'package:clase_db_app/modelo_producto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> abrirBase() async {
  final ruta = join(await getDatabasesPath(), 'mercado.db');
  return openDatabase(
    ruta,
    version: 1,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE productos(id INTEGER PRIMARY KEY, nombre TEXT, '
        'precio INTEGER, disponible INTEGER)',
      );
    },
  );
}

Future<void> insertarProducto(Database db, Producto producto) async {
  await db.insert('productos', producto.toMap());
}

Future<List<Producto>> leerProductos(Database db) async {
  final filas = await db.query('productos');
  return [for (final fila in filas) Producto.fromMap(fila)];
}

Future<void> borrarProducto(Database db, int id) async {
  await db.delete('productos', where: 'id = ?', whereArgs: [id]);
}
