// Ejemplo del módulo 04. Para verlo en pantalla:
//   flutter run -t modulos/04_widgets/ejemplo.dart
// (La primera vez leé "Ver los ejemplos en pantalla" en el README principal.)
import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarjeta de presentación',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const PantallaTarjeta(),
    );
  }
}

class PantallaTarjeta extends StatelessWidget {
  const PantallaTarjeta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi tarjeta')),
      body: const Center(
        child: TarjetaPersona(
          nombre: 'Daniela Ortez',
          carrera: 'Ingeniería en Informática',
          ciudad: 'San Pedro Sula',
        ),
      ),
    );
  }
}

/// Un widget propio: recibe datos y decide cómo se ven.
class TarjetaPersona extends StatelessWidget {
  const TarjetaPersona({
    super.key,
    required this.nombre,
    required this.carrera,
    required this.ciudad,
  });

  final String nombre;
  final String carrera;
  final String ciudad;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 32)),
            const SizedBox(height: 12),
            Text(nombre, style: tema.textTheme.titleLarge),
            Text(carrera),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.place, size: 16),
                const SizedBox(width: 4),
                Text(ciudad),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
