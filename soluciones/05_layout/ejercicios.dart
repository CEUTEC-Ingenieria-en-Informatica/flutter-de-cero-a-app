// Módulo 05 · Layout · una solución posible (hay otras).
import 'package:flutter/material.dart';

/// Ejercicio 1
class FilaProducto extends StatelessWidget {
  const FilaProducto({super.key, required this.nombre, required this.precio});

  final String nombre;
  final double precio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(nombre)),
          Text('L ${precio.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}

/// Ejercicio 2
class ListaContactos extends StatelessWidget {
  const ListaContactos({super.key, required this.nombres});

  final List<String> nombres;

  @override
  Widget build(BuildContext context) {
    if (nombres.isEmpty) {
      return const Center(child: Text('Sin contactos'));
    }
    return ListView.builder(
      itemCount: nombres.length,
      itemBuilder: (context, i) {
        final nombre = nombres[i];
        return ListTile(
          leading: CircleAvatar(child: Text(nombre[0].toUpperCase())),
          title: Text(nombre),
        );
      },
    );
  }
}

/// Ejercicio 3
class PerfilConInsignia extends StatelessWidget {
  const PerfilConInsignia({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        Positioned(right: 0, bottom: 0, child: Icon(Icons.verified)),
      ],
    );
  }
}

/// Ejercicio 4
class PanelResponsivo extends StatelessWidget {
  const PanelResponsivo({super.key, required this.izquierda, required this.derecha});

  final Widget izquierda;
  final Widget derecha;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, restricciones) {
        if (restricciones.maxWidth >= 600) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: izquierda),
              Expanded(child: derecha),
            ],
          );
        }
        return Column(children: [izquierda, derecha]);
      },
    );
  }
}

/// Ejercicio 5
class CuadriculaCategorias extends StatelessWidget {
  const CuadriculaCategorias({super.key, required this.categorias});

  final List<String> categorias;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        for (final categoria in categorias) Card(child: Center(child: Text(categoria))),
      ],
    );
  }
}
