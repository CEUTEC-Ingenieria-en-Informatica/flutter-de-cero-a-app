// Ejemplo del módulo 05. Para verlo en pantalla:
//   flutter run -t modulos/05_layout/ejemplo.dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PantallaMenu()));

const _menu = {
  'Revuelta': 25.0,
  'Queso': 22.0,
  'Frijol con queso': 22.0,
  'Loroco con queso': 28.0,
  'Chicharrón': 25.0,
};

class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú del día')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Encabezado de alto fijo con un Stack: imagen de fondo simulada y texto encima.
          SizedBox(
            height: 140,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Colors.orange.shade200),
                const Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text('Pupusas recién salidas del comal', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Elegí tus pupusas', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          // Expanded le da a la lista todo el alto que sobra. Sin él, la lista no sabe cuánto medir.
          Expanded(
            child: ListView.separated(
              itemCount: _menu.length,
              separatorBuilder: (context, i) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final nombre = _menu.keys.elementAt(i);
                final precio = _menu.values.elementAt(i);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(child: Text(nombre)),
                      Text('L ${precio.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
