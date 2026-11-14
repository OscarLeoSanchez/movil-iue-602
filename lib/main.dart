import 'package:clase_db_app/contador_pantalla.dart';
import 'package:clase_db_app/firebase_options.dart';
import 'package:clase_db_app/login_pantalla.dart';
import 'package:clase_db_app/productos_nube_pantalla.dart';
import 'package:clase_db_app/productos_pantalla.dart';
import 'package:clase_db_app/token_pantalla.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(home: PantallaPrincipal()));
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  void abrir(BuildContext context, Widget pantalla) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => pantalla));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('clase_nube')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Contador'),
            onTap: () => abrir(context, const ContadorPantalla()),
          ),
          ListTile(
            title: const Text('Token'),
            onTap: () => abrir(context, const TokenPantalla()),
          ),
          ListTile(
            title: const Text('Productos'),
            onTap: () => abrir(context, const ProductosPantalla()),
          ),
          ListTile(
            title: const Text('Login/Cuenta'),
            onTap: () => abrir(context, const LoginPantalla()),
          ),
          ListTile(
            title: const Text('Productos en la nube'),
            onTap: () => abrir(context, const ProductosNubePantalla()),
          ),
        ],
      ),
    );
  }
}
