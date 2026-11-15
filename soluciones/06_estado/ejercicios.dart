// Módulo 06 · Estado · una solución posible (hay otras).
import 'package:flutter/material.dart';

/// Ejercicio 1
class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _valor = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _valor == 0 ? null : () => setState(() => _valor--),
        ),
        Text('$_valor', key: const Key('valor')),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() => _valor++),
        ),
      ],
    );
  }
}

/// Ejercicio 2
class ModeloCarrito extends ChangeNotifier {
  final List<(String, double)> _articulos = [];

  List<String> get articulos => List.unmodifiable(_articulos.map((a) => a.$1));

  int get cantidad => _articulos.length;

  double get total => _articulos.fold(0.0, (suma, a) => suma + a.$2);

  void agregar(String nombre, double precio) {
    _articulos.add((nombre, precio));
    notifyListeners();
  }

  void quitar(String nombre) {
    final i = _articulos.indexWhere((a) => a.$1 == nombre);
    if (i == -1) return;
    _articulos.removeAt(i);
    notifyListeners();
  }

  void vaciar() {
    if (_articulos.isEmpty) return;
    _articulos.clear();
    notifyListeners();
  }
}

/// Ejercicio 3
class InterruptorTema extends StatelessWidget {
  const InterruptorTema({super.key, required this.oscuro});

  final ValueNotifier<bool> oscuro;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: oscuro,
      builder: (context, valor, _) {
        return SwitchListTile(
          title: Text(valor ? 'Modo oscuro' : 'Modo claro'),
          value: valor,
          onChanged: (nuevo) => oscuro.value = nuevo,
        );
      },
    );
  }
}

/// Ejercicio 4
class ResumenCarrito extends StatelessWidget {
  const ResumenCarrito({super.key, required this.carrito});

  final ModeloCarrito carrito;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: carrito,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Artículos: ${carrito.cantidad}'),
            Text('Total: L ${carrito.total.toStringAsFixed(2)}'),
            TextButton(
              onPressed: carrito.cantidad == 0 ? null : carrito.vaciar,
              child: const Text('Vaciar'),
            ),
          ],
        );
      },
    );
  }
}
