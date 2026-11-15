// Módulo 12 · Proyecto final · el pedido · una solución posible (hay otras).
import 'package:flutter/foundation.dart';

import '../../modulos/12_proyecto_final/modelos.dart';

class Pedido extends ChangeNotifier {
  // Un Map recuerda el orden en que se agregaron las claves.
  final Map<String, int> _cantidades = {};

  List<(Producto, int)> get lineas => [
        for (final entrada in _cantidades.entries) (productoPorId(entrada.key), entrada.value),
      ];

  bool get estaVacio => _cantidades.isEmpty;

  int cantidadDe(Producto producto) => _cantidades[producto.id] ?? 0;

  int get totalArticulos => _cantidades.values.fold(0, (s, c) => s + c);

  int get totalPupusas => lineas
      .where((l) => l.$1.categoria == Categoria.pupusas)
      .fold(0, (s, l) => s + l.$2);

  double get subtotal => redondear(lineas.fold(0.0, (s, l) => s + l.$1.precio * l.$2));

  double get descuento {
    if (totalPupusas < pupusasParaPromo) return 0;
    final enPupusas = lineas
        .where((l) => l.$1.categoria == Categoria.pupusas)
        .fold(0.0, (s, l) => s + l.$1.precio * l.$2);
    return redondear(enPupusas * descuentoPromo);
  }

  double get isv => redondear((subtotal - descuento) * tasaIsv);

  double get total => redondear(subtotal - descuento + isv);

  void agregar(Producto producto) {
    _cantidades[producto.id] = cantidadDe(producto) + 1;
    notifyListeners();
  }

  void quitar(Producto producto) {
    final actual = cantidadDe(producto);
    if (actual == 0) return;
    if (actual == 1) {
      _cantidades.remove(producto.id);
    } else {
      _cantidades[producto.id] = actual - 1;
    }
    notifyListeners();
  }

  void vaciar() {
    if (_cantidades.isEmpty) return;
    _cantidades.clear();
    notifyListeners();
  }

  String resumenParaCocina() => [for (final (p, c) in lineas) '$c x ${p.nombre}'].join('\n');
}
