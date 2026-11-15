// Módulo 11 · Tests · una solución posible (hay otras).
import 'dart:async';

import 'package:flutter/material.dart';

/// Ejercicio 1
bool estaAbierto(DateTime momento) {
  final minutos = momento.hour * 60 + momento.minute;
  if (momento.weekday == DateTime.sunday) {
    return minutos >= 8 * 60 && minutos < 14 * 60;
  }
  return minutos >= 7 * 60 && minutos < 21 * 60;
}

/// Ejercicio 2
class SaludoDelDia {
  SaludoDelDia({DateTime Function()? ahora}) : _ahora = ahora ?? DateTime.now;

  final DateTime Function() _ahora;

  String saludo() {
    final hora = _ahora().hour;
    if (hora < 12) return 'Buenos días';
    if (hora < 18) return 'Buenas tardes';
    return 'Buenas noches';
  }
}

/// Ejercicio 3
const denominaciones = [500, 200, 100, 50, 20, 10, 5, 2, 1];

Map<int, int> desgloseVuelto(int total, int pagado) {
  if (pagado < total) {
    throw ArgumentError('Lo pagado no alcanza');
  }
  var resto = pagado - total;
  final desglose = <int, int>{};
  for (final d in denominaciones) {
    final cuantos = resto ~/ d;
    if (cuantos > 0) {
      desglose[d] = cuantos;
      resto -= cuantos * d;
    }
  }
  return desglose;
}

/// Ejercicio 4
class CampoBusqueda extends StatefulWidget {
  const CampoBusqueda({
    super.key,
    required this.alBuscar,
    this.espera = const Duration(milliseconds: 300),
  });

  final ValueChanged<String> alBuscar;
  final Duration espera;

  @override
  State<CampoBusqueda> createState() => _CampoBusquedaState();
}

class _CampoBusquedaState extends State<CampoBusqueda> {
  Timer? _temporizador;

  void _alEscribir(String texto) {
    _temporizador?.cancel();
    _temporizador = Timer(widget.espera, () => widget.alBuscar(texto.trim()));
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _alEscribir,
      decoration: const InputDecoration(labelText: 'Buscar', prefixIcon: Icon(Icons.search)),
    );
  }
}
