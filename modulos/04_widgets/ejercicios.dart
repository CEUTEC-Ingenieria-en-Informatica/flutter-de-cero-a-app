// Módulo 04 · Widgets · ejercicios
//
// Cada widget devuelve un Placeholder (un rectángulo con una X). Cambialo por lo que pide.
// Para revisar solo este módulo: flutter test test/m04_widgets_test.dart
import 'package:flutter/material.dart';

/// Ejercicio 1
/// Una Card con un Row adentro: el ícono Icons.waving_hand y el texto 'Hola, ' más el nombre.
/// Ponele un Padding de 16 dentro de la Card para que no quede pegado al borde.
class TarjetaSaludo extends StatelessWidget {
  const TarjetaSaludo({super.key, required this.nombre});

  final String nombre;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 2
/// Si el precio es 0, mostrá el texto 'Gratis' en color Colors.green.
/// Si no, mostrá el precio como 'L 35.00'.
class EtiquetaPrecio extends StatelessWidget {
  const EtiquetaPrecio({super.key, required this.precio});

  final double precio;

  @override
  Widget build(BuildContext context) {
    // TODO: un if antes del return también vale en build.
    return const Placeholder();
  }
}

/// Ejercicio 3
/// Un ElevatedButton que muestra [texto] y llama a [alPresionar] cuando lo tocan.
class BotonAccion extends StatelessWidget {
  const BotonAccion({super.key, required this.texto, required this.alPresionar});

  final String texto;
  final VoidCallback alPresionar;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 4
/// Una pantalla completa con Scaffold:
/// 1. AppBar con el título 'Mi primera app'.
/// 2. En el cuerpo, centrado, el texto 'Bienvenido a Flutter'.
/// 3. Un FloatingActionButton con Icons.add que llama a [alPresionarMas].
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key, required this.alPresionarMas});

  final VoidCallback alPresionarMas;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 5
/// Una etiqueta redondeada: un Container con BoxDecoration de color [color] y
/// borderRadius de 12, y adentro [texto] en blanco.
/// Padding sugerido: 12 a los lados y 4 arriba y abajo.
class Insignia extends StatelessWidget {
  const Insignia({super.key, required this.texto, this.color = Colors.indigo});

  final String texto;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
