import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContadorPantalla extends StatefulWidget {
  const ContadorPantalla({super.key});

  @override
  State<StatefulWidget> createState() => _ContadorPantallaState();
}

class _ContadorPantallaState extends State<ContadorPantalla> {
  int contador = 0;
  final prefs = SharedPreferencesAsync();

  @override
  void initState() {
    super.initState();
    cargar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> cargar() async {
    final guardado = await prefs.getInt('contador') ?? 0;
    setState(() => contador = guardado);
  }

  Future<void> sumar() async {
    setState(() => contador++);
    await prefs.setInt('contador', contador);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contador guardado')),
      body: Center(
        child: Text(
          '$contador',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sumar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
