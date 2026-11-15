// Módulo 03 · Clases y null safety · una solución posible (hay otras).
import 'dart:math' as math;

/// Ejercicio 1
class Producto {
  Producto(String nombre, this.precio) : nombre = nombre.trim() {
    if (this.nombre.isEmpty) {
      throw ArgumentError('El nombre no puede ir vacío');
    }
    if (precio < 0) {
      throw ArgumentError('El precio no puede ser negativo');
    }
  }

  final String nombre;
  final double precio;

  String get etiqueta => '$nombre, L ${precio.toStringAsFixed(2)}';

  Producto copiarCon({String? nombre, double? precio}) {
    return Producto(nombre ?? this.nombre, precio ?? this.precio);
  }
}

/// Ejercicio 2
class Cuenta {
  Cuenta(this.titular);

  final String titular;
  double _saldo = 0;

  double get saldo => _saldo;

  void depositar(double monto) {
    if (monto <= 0) {
      throw ArgumentError('El depósito tiene que ser mayor que cero');
    }
    _saldo += monto;
  }

  bool retirar(double monto) {
    if (monto <= 0 || monto > _saldo) {
      return false;
    }
    _saldo -= monto;
    return true;
  }
}

/// Ejercicio 3
String nombreParaMostrar(String? apodo, String nombre) {
  final limpio = apodo?.trim();
  if (limpio == null || limpio.isEmpty) {
    return nombre;
  }
  return limpio;
}

/// Ejercicio 4
int largoSeguro(String? texto) => texto?.length ?? 0;

/// Ejercicio 5
abstract class Figura {
  double get area;
}

class Rectangulo extends Figura {
  Rectangulo(this.ancho, this.alto);

  final double ancho;
  final double alto;

  @override
  double get area => ancho * alto;
}

class Circulo extends Figura {
  Circulo(this.radio);

  final double radio;

  @override
  double get area => math.pi * radio * radio;
}

double areaTotal(List<Figura> figuras) {
  return figuras.fold(0.0, (suma, f) => suma + f.area);
}

/// Ejercicio 6
class Cliente {
  Cliente({required this.nombre, this.telefono, this.puntos = 0});

  factory Cliente.desdeMapa(Map<String, Object?> datos) {
    final nombre = datos['nombre'];
    if (nombre is! String || nombre.trim().isEmpty) {
      throw const FormatException('Falta el nombre del cliente');
    }
    final telefono = datos['telefono'];
    final puntos = datos['puntos'];
    return Cliente(
      nombre: nombre.trim(),
      telefono: telefono is String ? telefono : null,
      puntos: puntos is int ? puntos : 0,
    );
  }

  final String nombre;
  final String? telefono;
  final int puntos;

  bool get tieneTelefono => telefono != null;
}
