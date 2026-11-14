import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPantalla extends StatefulWidget {
  const LoginPantalla({super.key});

  @override
  State<LoginPantalla> createState() => _LoginPantallaState();
}

class _LoginPantallaState extends State<LoginPantalla> {
  final auth = FirebaseAuth.instance;
  final correo = TextEditingController();
  final clave = TextEditingController();
  String? error;

  Future<void> registrar() {
    return probar(
      () => auth.createUserWithEmailAndPassword(
        email: correo.text.trim(),
        password: clave.text,
      ),
    );
  }

  Future<void> iniciar() {
    return probar(
      () => auth.signInWithEmailAndPassword(
        email: correo.text.trim(),
        password: clave.text,
      ),
    );
  }

  Future<void> probar(Future<void> Function() accion) async {
    setState(() => error = null);
    try {
      await accion();
    } on FirebaseAuthException catch (e) {
      if (mounted) setState(() => error = mensajeDe(e.code));
    }
  }

  String mensajeDe(String codigo) {
    switch (codigo) {
      case 'email-already-in-use':
        return 'Ese correo ya tiene una cuenta';
      case 'weak-password':
        return 'La contraseña es muy corta: usa al menos 6 caracteres';
      case 'invalid-email':
        return 'El correo no tiene un formato válido';
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos';
      case 'network-request-failed':
        return 'Sin conexión: revisa tu internet';
      default:
        return 'Error: $codigo';
    }
  }

  @override
  void dispose() {
    correo.dispose();
    clave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            final usuario = snapshot.data;
            if (usuario != null) {
              return Column(
                children: [
                  Text('Sesión iniciada: ${usuario.email}'),
                  FilledButton(
                    onPressed: auth.signOut,
                    child: const Text('Cerrar sesión'),
                  ),
                ],
              );
            }
            return Column(
              children: [
                TextField(
                  controller: correo,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: clave,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                ),
                if (error != null) Text(error!),
                Row(
                  children: [
                    FilledButton(
                      onPressed: registrar,
                      child: const Text('Registrar'),
                    ),
                    TextButton(
                      onPressed: iniciar,
                      child: const Text('Iniciar sesión'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
