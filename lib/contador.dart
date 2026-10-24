import 'package:flutter/material.dart';

class Contador1 extends StatelessWidget {
  const Contador1({super.key});

  @override
  Widget build(BuildContext context) {
    int contador = 0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Contador'),
        Text('$contador'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                contador--;
                print(contador);
              },
              icon: Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () {
                contador++;
                print(contador);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ContadorState();
  }
}

class _ContadorState extends State<Contador> {
  var contador;

  @override
  void initState() {
    super.initState();
    contador = 10;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Contador'),
        Text('$contador'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  contador--;
                  print(contador);
                });
              },
              icon: Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  contador++;
                  print(contador);
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
