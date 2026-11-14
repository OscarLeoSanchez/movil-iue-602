import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenPantalla extends StatefulWidget {
  const TokenPantalla({super.key});

  @override
  State<StatefulWidget> createState() => _TokenPantallaState();
}

class _TokenPantallaState extends State<TokenPantalla> {
  String? token;
  final almacen = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    leer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> escribir() async {
    await almacen.write(key: 'token', value: 'token-de-prueba-123');
    await leer();
  }

  Future<void> leer() async {
    final guardado = await almacen.read(key: 'token');
    setState(() => token = guardado);
  }

  Future<void> borrar() async {
    await almacen.delete(key: 'token');
    await leer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Token seguro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(token ?? 'Sin token guardado'),
            Row(
              children: [
                FilledButton(onPressed: escribir, child: const Text('Guardar')),
                TextButton(onPressed: borrar, child: const Text('Borrar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
