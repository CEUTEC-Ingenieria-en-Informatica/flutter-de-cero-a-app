// Módulo 03 · Clases y null safety · ejercicios
//
// Completá cada TODO. Para revisar solo este módulo:
// flutter test test/m03_clases_y_null_safety_test.dart
//
// Para el ejercicio 5 vas a necesitar pi: agregá aquí arriba import 'dart:math' as math;

/// Ejercicio 1
/// Un producto del menú.
/// 1. Guardá el nombre sin espacios sobrantes.
/// 2. Si el nombre queda vacío o el precio es negativo, lanzá un ArgumentError.
/// 3. etiqueta devuelve 'Horchata, L 20.00'.
/// 4. copiarCon devuelve un Producto NUEVO cambiando solo lo que te manden.
class Producto {
  // TODO: limpiá el nombre en la lista de inicialización y validá en el cuerpo.
  Producto(this.nombre, this.precio);

  final String nombre;
  final double precio;

  String get etiqueta => throw UnimplementedError('TODO ejercicio 1, etiqueta');

  Producto copiarCon({String? nombre, double? precio}) {
    // TODO: usá ?? para quedarte con el valor actual cuando no mandan uno.
    throw UnimplementedError('TODO ejercicio 1, copiarCon');
  }
}

/// Ejercicio 2
/// Una cuenta con saldo privado.
/// 1. El saldo arranca en 0 y solo se lee desde afuera (getter saldo).
/// 2. depositar suma; si el monto es 0 o negativo, lanza ArgumentError.
/// 3. retirar resta y devuelve true. Si el monto es 0, negativo o mayor que el saldo, no hace nada y devuelve false.
class Cuenta {
  Cuenta(this.titular);

  final String titular;
  // TODO: agregá un campo privado para el saldo (empieza con guion bajo).

  double get saldo => throw UnimplementedError('TODO ejercicio 2, saldo');

  void depositar(double monto) {
    // TODO
    throw UnimplementedError('TODO ejercicio 2, depositar');
  }

  bool retirar(double monto) {
    // TODO
    throw UnimplementedError('TODO ejercicio 2, retirar');
  }
}

/// Ejercicio 3
/// Si hay apodo (sin contar espacios), se muestra el apodo limpio. Si es null o vacío, el nombre.
String nombreParaMostrar(String? apodo, String nombre) {
  // TODO: apodo?.trim() te devuelve null si apodo es null.
  throw UnimplementedError('TODO ejercicio 3');
}

/// Ejercicio 4
/// Largo del texto, o 0 si es null. Hacelo en una línea con ?. y ??.
int largoSeguro(String? texto) {
  // TODO
  throw UnimplementedError('TODO ejercicio 4');
}

/// Ejercicio 5
/// Figura es abstracta: solo dice que toda figura tiene área.
/// Completá el área de Rectangulo (ancho por alto) y de Circulo (pi por radio al cuadrado),
/// y areaTotal, que suma el área de todas.
abstract class Figura {
  double get area;
}

class Rectangulo extends Figura {
  Rectangulo(this.ancho, this.alto);

  final double ancho;
  final double alto;

  @override
  double get area => throw UnimplementedError('TODO ejercicio 5, Rectangulo');
}

class Circulo extends Figura {
  Circulo(this.radio);

  final double radio;

  // TODO: usá math.pi (mirá el import que dice arriba).
  @override
  double get area => throw UnimplementedError('TODO ejercicio 5, Circulo');
}

double areaTotal(List<Figura> figuras) {
  // TODO
  throw UnimplementedError('TODO ejercicio 5, areaTotal');
}

/// Ejercicio 6
/// Cliente.desdeMapa arma un cliente desde un mapa como los que vienen de un JSON.
/// 1. 'nombre' es obligatorio: si falta, no es String o está vacío, lanzá FormatException.
/// 2. 'telefono' es opcional: si no es String, queda null.
/// 3. 'puntos' es opcional: si no es int, queda 0.
/// 4. tieneTelefono dice si hay teléfono.
class Cliente {
  Cliente({required this.nombre, this.telefono, this.puntos = 0});

  factory Cliente.desdeMapa(Map<String, Object?> datos) {
    // TODO: usá `is` para revisar el tipo de cada valor.
    throw UnimplementedError('TODO ejercicio 6, desdeMapa');
  }

  final String nombre;
  final String? telefono;
  final int puntos;

  bool get tieneTelefono => throw UnimplementedError('TODO ejercicio 6, tieneTelefono');
}
