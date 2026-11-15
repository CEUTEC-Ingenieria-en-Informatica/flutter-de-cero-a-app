// Módulo 12 · Proyecto final · el pedido
//
// La lógica del negocio, sin nada de pantallas. Hacé esto primero: los tests de esta parte
// corren en milisegundos y te avisan rápido si algo no cuadra.
import 'package:flutter/foundation.dart';

import '../../modulos/12_proyecto_final/modelos.dart';

/// El pedido de un cliente. Avisa con notifyListeners() cada vez que cambia.
///
/// Reglas:
/// 1. agregar suma una unidad del producto. quitar resta una; si llega a 0, el producto sale del pedido.
///    Quitar algo que no está no hace nada ni avisa. Vaciar un pedido vacío tampoco avisa.
/// 2. lineas devuelve (producto, cantidad) en el orden en que se agregó cada producto por primera vez.
/// 3. subtotal es la suma de precio por cantidad.
/// 4. Promoción: si hay 12 pupusas o más (sumando todos los sabores, sin contar bebidas),
///    descuento es el 10 % de lo que suman las pupusas. Si no, 0. Mirá pupusasParaPromo y descuentoPromo.
/// 5. isv es el 15 % de (subtotal menos descuento). total es subtotal menos descuento más isv.
///    Redondeá cada monto a centavos con redondear().
/// 6. resumenParaCocina devuelve una línea por producto, como '2 x Revuelta', unidas con salto de línea.
class Pedido extends ChangeNotifier {
  // TODO: guardá las cantidades. Un Map<String, int> por id de producto recuerda el orden.

  List<(Producto, int)> get lineas => throw UnimplementedError('TODO lineas');

  bool get estaVacio => throw UnimplementedError('TODO estaVacio');

  int cantidadDe(Producto producto) => throw UnimplementedError('TODO cantidadDe');

  int get totalArticulos => throw UnimplementedError('TODO totalArticulos');

  int get totalPupusas => throw UnimplementedError('TODO totalPupusas');

  double get subtotal => throw UnimplementedError('TODO subtotal');

  double get descuento => throw UnimplementedError('TODO descuento');

  double get isv => throw UnimplementedError('TODO isv');

  double get total => throw UnimplementedError('TODO total');

  void agregar(Producto producto) {
    throw UnimplementedError('TODO agregar');
  }

  void quitar(Producto producto) {
    throw UnimplementedError('TODO quitar');
  }

  void vaciar() {
    throw UnimplementedError('TODO vaciar');
  }

  String resumenParaCocina() => throw UnimplementedError('TODO resumenParaCocina');
}
