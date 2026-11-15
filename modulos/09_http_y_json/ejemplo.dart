// Ejemplo del módulo 09. Para verlo en pantalla:
//   flutter run -t modulos/09_http_y_json/ejemplo.dart
//
// La app usa una fuente que simula la red con una espera, para que veás el indicador de carga
// sin depender de un servidor. En el README está cómo se ve un cliente real.
import 'dart:convert';

import 'package:flutter/material.dart';

class Aviso {
  const Aviso({required this.titulo, required this.fecha});

  // fromJson: de Map a objeto. Revisá tipos con `as` y convertí lo que haga falta.
  factory Aviso.fromJson(Map<String, dynamic> json) => Aviso(
        titulo: json['titulo'] as String,
        fecha: DateTime.parse(json['fecha'] as String),
      );

  final String titulo;
  final DateTime fecha;
}

abstract class Fuente {
  Future<String> leer(Uri url);
}

/// Simula la red: espera un segundo y devuelve un JSON fijo.
class FuenteSimulada implements Fuente {
  @override
  Future<String> leer(Uri url) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return '[{"titulo": "Taller de Flutter el sábado", "fecha": "2026-11-21"},'
        ' {"titulo": "Reto de UI del mes", "fecha": "2026-11-30"}]';
  }
}

Future<List<Aviso>> cargarAvisos(Fuente fuente) async {
  final texto = await fuente.leer(Uri.parse('https://api.example.com/avisos'));
  final lista = jsonDecode(texto) as List<dynamic>;
  return lista.map((e) => Aviso.fromJson(e as Map<String, dynamic>)).toList();
}

void main() => runApp(MaterialApp(home: PantallaAvisos(fuente: FuenteSimulada())));

class PantallaAvisos extends StatefulWidget {
  const PantallaAvisos({super.key, required this.fuente});
  final Fuente fuente;

  @override
  State<PantallaAvisos> createState() => _PantallaAvisosState();
}

class _PantallaAvisosState extends State<PantallaAvisos> {
  late final Future<List<Aviso>> _avisos = cargarAvisos(widget.fuente);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avisos de la comunidad')),
      body: FutureBuilder<List<Aviso>>(
        future: _avisos,
        builder: (context, foto) {
          if (foto.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (foto.hasError) {
            return Center(child: Text('Algo salió mal: ${foto.error}'));
          }
          return ListView(
            children: [
              for (final a in foto.data!)
                ListTile(
                  leading: const Icon(Icons.campaign),
                  title: Text(a.titulo),
                  subtitle: Text('${a.fecha.day}/${a.fecha.month}/${a.fecha.year}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
