// Módulo 05 · Layout · ejercicios
//
// Cambiá cada Placeholder por el layout que pide.
// Para revisar solo este módulo: flutter test test/m05_layout_test.dart
import 'package:flutter/material.dart';

/// Ejercicio 1
/// Una fila con el nombre a la izquierda y el precio ('L 25.00') pegado a la derecha.
/// 1. Envolvé todo en un Padding de 16 a los lados y 8 arriba y abajo.
/// 2. El nombre va dentro de un Expanded para que ocupe el espacio que sobra.
class FilaProducto extends StatelessWidget {
  const FilaProducto({super.key, required this.nombre, required this.precio});

  final String nombre;
  final double precio;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 2
/// 1. Si no hay nombres, mostrá centrado el texto 'Sin contactos'.
/// 2. Si hay, usá ListView.builder con un ListTile por nombre:
///    leading es un CircleAvatar con la primera letra en mayúscula y title es el nombre.
class ListaContactos extends StatelessWidget {
  const ListaContactos({super.key, required this.nombres});

  final List<String> nombres;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 3
/// Un Stack con un CircleAvatar de radio 40 (con Icons.person adentro) y,
/// encima, el ícono Icons.verified pegado a la esquina de abajo a la derecha con Positioned.
class PerfilConInsignia extends StatelessWidget {
  const PerfilConInsignia({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 4
/// Con LayoutBuilder:
/// 1. Si el ancho disponible es 600 o más, [izquierda] y [derecha] van lado a lado
///    en un Row, cada una dentro de un Expanded.
/// 2. Si es menos de 600, van una debajo de la otra en un Column.
class PanelResponsivo extends StatelessWidget {
  const PanelResponsivo({super.key, required this.izquierda, required this.derecha});

  final Widget izquierda;
  final Widget derecha;

  @override
  Widget build(BuildContext context) {
    // TODO: LayoutBuilder te da las restricciones (constraints) del padre.
    return const Placeholder();
  }
}

/// Ejercicio 5
/// Una cuadrícula de 2 columnas (GridView.count) con una Card por categoría
/// y el nombre centrado adentro.
class CuadriculaCategorias extends StatelessWidget {
  const CuadriculaCategorias({super.key, required this.categorias});

  final List<String> categorias;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
