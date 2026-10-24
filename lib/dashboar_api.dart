import 'package:consumo_api_app/consulta_api.dart';
import 'package:flutter/material.dart';

class DashboardApi extends StatefulWidget {
  const DashboardApi({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardApiState();
}

class _DashboardApiState extends State<DashboardApi> {
  Clima? clima;

  @override
  void initState() {
    super.initState();
    updateClima();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text('Temperatura: ${clima?.temperatura}')),
        ElevatedButton(onPressed: updateClima, child: Text('Actualizar')),
      ],
    );
  }

  void updateClima() {
    getClima().then((value) {
      setState(() {
        clima = value;
        clima?.imprimirClima();
      });
    });
  }
}
