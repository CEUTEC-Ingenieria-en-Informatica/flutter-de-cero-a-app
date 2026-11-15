// Módulo 06 · Estado · ejercicios
//
// Sin librerías externas: solo setState, ValueNotifier y ChangeNotifier, que vienen con Flutter.
// Para revisar solo este módulo: flutter test test/m06_estado_test.dart
import 'package:flutter/material.dart';

/// Ejercicio 1
/// Un contador con dos IconButton: Icons.remove a la izquierda y Icons.add a la derecha.
/// 1. En medio, el valor como Text con key: const Key('valor'). Arranca en 0.
/// 2. El de sumar suma 1. El de restar resta 1, pero nunca baja de 0:
///    cuando el valor es 0, el botón de restar queda desactivado (onPressed: null).
class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  // TODO: guardá aquí el valor y cambialo dentro de setState.

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 2
/// El modelo de un carrito. Cada vez que algo cambia, avisá con notifyListeners().
/// 1. agregar guarda un artículo con su precio.
/// 2. quitar borra el PRIMER artículo con ese nombre. Si no existe, no hace nada ni avisa.
/// 3. vaciar borra todo. Si ya estaba vacío, no avisa.
/// 4. articulos devuelve los nombres en el orden en que se agregaron, en una lista que no se pueda cambiar desde afuera.
/// 5. cantidad y total se calculan con lo que hay.
class ModeloCarrito extends ChangeNotifier {
  // TODO: una lista privada. Un record (String, double) sirve para guardar nombre y precio juntos.

  List<String> get articulos => throw UnimplementedError('TODO ejercicio 2, articulos');

  int get cantidad => throw UnimplementedError('TODO ejercicio 2, cantidad');

  double get total => throw UnimplementedError('TODO ejercicio 2, total');

  void agregar(String nombre, double precio) {
    throw UnimplementedError('TODO ejercicio 2, agregar');
  }

  void quitar(String nombre) {
    throw UnimplementedError('TODO ejercicio 2, quitar');
  }

  void vaciar() {
    throw UnimplementedError('TODO ejercicio 2, vaciar');
  }
}

/// Ejercicio 3
/// Un SwitchListTile conectado a un `ValueNotifier<bool>` con ValueListenableBuilder.
/// 1. El título dice 'Modo oscuro' si el valor es true y 'Modo claro' si es false.
/// 2. Al tocar el switch, cambiá oscuro.value.
/// 3. Si alguien cambia oscuro.value desde afuera, el switch se tiene que actualizar solo.
class InterruptorTema extends StatelessWidget {
  const InterruptorTema({super.key, required this.oscuro});

  final ValueNotifier<bool> oscuro;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 4
/// Escuchá el carrito con ListenableBuilder y mostrá en un Column:
/// 1. 'Artículos: 2'
/// 2. 'Total: L 47.00'
/// 3. Un TextButton 'Vaciar' que vacía el carrito. Desactivado si no hay artículos.
class ResumenCarrito extends StatelessWidget {
  const ResumenCarrito({super.key, required this.carrito});

  final ModeloCarrito carrito;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
