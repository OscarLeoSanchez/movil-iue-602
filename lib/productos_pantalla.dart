import 'package:clase_db_app/base_datos.dart';
import 'package:clase_db_app/modelo_producto.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ProductosPantalla extends StatefulWidget {
  const ProductosPantalla({super.key});

  @override
  State<StatefulWidget> createState() => _ProductosPantallaState();
}

class _ProductosPantallaState extends State<ProductosPantalla> {
  final nombre = TextEditingController();
  final precio = TextEditingController();

  List<Producto> productos = [];
  Database? db;

  @override
  void initState() {
    super.initState();
    iniciar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> iniciar() async {
    db = await abrirBase();
    await cargar();
  }

  Future<void> cargar() async {
    final lista = await leerProductos(db!);
    setState(() => productos = lista);
  }

  Future<void> agregar() async {
    final producto = Producto(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: nombre.text,
      precio: int.tryParse(precio.text) ?? 0,
      disponible: true,
    );
    await insertarProducto(db!, producto);
    nombre.clear();
    precio.clear();
    await cargar();
  }

  Future<void> borrar(int id) async {
    await borrarProducto(db!, id);
    await cargar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos guardados')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombre,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: precio,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            FilledButton(onPressed: agregar, child: const Text('Agregar')),
            Expanded(
              child: ListView(
                children: [
                  for (final p in productos)
                    ListTile(
                      title: Text(p.nombre),
                      subtitle: Text('\$${p.precio}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => borrar(p.id),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
