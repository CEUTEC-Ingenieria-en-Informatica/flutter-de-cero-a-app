// Módulo 04 · Widgets · una solución posible (hay otras).
import 'package:flutter/material.dart';

/// Ejercicio 1
class TarjetaSaludo extends StatelessWidget {
  const TarjetaSaludo({super.key, required this.nombre});

  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.waving_hand),
            const SizedBox(width: 8),
            Text('Hola, $nombre'),
          ],
        ),
      ),
    );
  }
}

/// Ejercicio 2
class EtiquetaPrecio extends StatelessWidget {
  const EtiquetaPrecio({super.key, required this.precio});

  final double precio;

  @override
  Widget build(BuildContext context) {
    if (precio == 0) {
      return const Text('Gratis', style: TextStyle(color: Colors.green));
    }
    return Text('L ${precio.toStringAsFixed(2)}');
  }
}

/// Ejercicio 3
class BotonAccion extends StatelessWidget {
  const BotonAccion({super.key, required this.texto, required this.alPresionar});

  final String texto;
  final VoidCallback alPresionar;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: alPresionar, child: Text(texto));
  }
}

/// Ejercicio 4
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key, required this.alPresionarMas});

  final VoidCallback alPresionarMas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi primera app')),
      body: const Center(child: Text('Bienvenido a Flutter')),
      floatingActionButton: FloatingActionButton(
        onPressed: alPresionarMas,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Ejercicio 5
class Insignia extends StatelessWidget {
  const Insignia({super.key, required this.texto, this.color = Colors.indigo});

  final String texto;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(texto, style: const TextStyle(color: Colors.white)),
    );
  }
}
