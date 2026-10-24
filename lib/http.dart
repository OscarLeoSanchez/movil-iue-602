import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> main() async {
  final url =
      "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,precipitation,rain,wind_speed_10m";
  final response = await http.get(Uri.parse(url));

  final datos = jsonDecode(response.body);

  final clima = Clima.fromJson(datos);

  clima.imprimirClima();
}

class Clima {
  final fecha;
  final temperatura;
  final precipitacion;
  final lluvia;
  final velocidadViento;

  Clima({
    required this.fecha,
    required this.temperatura,
    required this.precipitacion,
    required this.lluvia,
    required this.velocidadViento,
  });

  factory Clima.fromJson(Map<String, dynamic> json) {
    final dato = json['current'];
    return Clima(
      fecha: dato['time'],
      temperatura: dato['temperature_2m'],
      precipitacion: dato['precipitation'],
      lluvia: dato['rain'],
      velocidadViento: dato['wind_speed_10m'],
    );
  }

  void imprimirClima() {
    print('------------------------------');
    print('Fecha: $fecha');
    print('Temperatura: $temperatura °C');
    print('Precipitación: $precipitacion mm');
    print('Lluvia: $lluvia mm');
    print('Velocidad del viento: $velocidadViento km/h');
    print('------------------------------');
  }
}
