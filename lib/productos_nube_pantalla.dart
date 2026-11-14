import 'package:clase_db_app/modelo_producto_nube.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductosNubePantalla extends StatefulWidget {
  const ProductosNubePantalla({super.key});

  @override
  State<ProductosNubePantalla> createState() => _ProductosNubePantallaState();
}

class _ProductosNubePantallaState extends State<ProductosNubePantalla> {
  final productos = FirebaseFirestore.instance.collection('productos');
  final nombre = TextEditingController();
  final precio = TextEditingController();
  String? error;

  Future<void> probar(Future<void> Function() accion) async {
    setState(() => error = null);
    try {
      await accion();
    } on FirebaseException catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.code == 'permission-denied'
            ? 'Inicia sesión para guardar cambios'
            : 'Error: ${e.code}';
      });
    }
  }

  Future<void> agregar() {
    return probar(() async {
      await productos.add({
        'nombre': nombre.text,
        'precio': int.tryParse(precio.text) ?? 0,
        'disponible': true,
      });
      nombre.clear();
      precio.clear();
    });
  }

  @override
  void dispose() {
    nombre.dispose();
    precio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos en la nube')),
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
            if (error != null) Text(error!),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: productos.snapshots(),
                builder: (context, snap) {
                  if (snap.hasError)
                    return Text('No se pudo leer: ${snap.error}');
                  if (!snap.hasData) return const CircularProgressIndicator();
                  return ListView(
                    children: [
                      for (final doc in snap.data!.docs)
                        filaDe(ProductoNube.fromDoc(doc)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filaDe(ProductoNube p) {
    return ListTile(
      leading: Switch(
        value: p.disponible,
        onChanged: (v) =>
            probar(() => productos.doc(p.id).update({'disponible': v})),
      ),
      title: Text(p.nombre),
      subtitle: Text('\$${p.precio}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => probar(() => productos.doc(p.id).delete()),
      ),
    );
  }
}
