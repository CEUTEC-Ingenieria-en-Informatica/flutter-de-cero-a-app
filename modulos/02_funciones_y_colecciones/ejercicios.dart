// Módulo 02 · Funciones y colecciones · ejercicios
//
// Cambiá cada `throw UnimplementedError(...)` por tu código.
// Para revisar solo este módulo: flutter test test/m02_funciones_y_colecciones_test.dart

/// Ejercicio 1
/// Sumá todos los precios de la lista. Con lista vacía devolvé 0.
/// Intentalo con fold en vez de un for.
double sumarPrecios(List<double> precios) {
  // TODO
  throw UnimplementedError('TODO ejercicio 1');
}

/// Ejercicio 2
/// Devolvé una lista NUEVA con cada nombre en mayúscula. No cambiés la lista original.
List<String> enMayuscula(List<String> nombres) {
  // TODO: map y toList.
  throw UnimplementedError('TODO ejercicio 2');
}

/// Ejercicio 3
/// Devolvé solo los números pares, en el mismo orden.
List<int> soloPares(List<int> numeros) {
  // TODO: where.
  throw UnimplementedError('TODO ejercicio 3');
}

/// Ejercicio 4
/// Parámetros con nombre y valor por defecto.
/// describirPlato('Baleada', precio: 35) devuelve 'Baleada: L 35.00'.
/// describirPlato('Sopa', precio: 80, picante: true) devuelve 'Sopa: L 80.00 (picante)'.
String describirPlato(String nombre, {double precio = 0, bool picante = false}) {
  // TODO
  throw UnimplementedError('TODO ejercicio 4');
}

/// Ejercicio 5
/// Parámetro opcional posicional: si no mandan porcentaje, el descuento es de 10 %.
/// aplicarDescuento(200) devuelve 180.0 y aplicarDescuento(200, 25) devuelve 150.0.
double aplicarDescuento(double precio, [double porcentaje = 10]) {
  // TODO
  throw UnimplementedError('TODO ejercicio 5');
}

/// Ejercicio 6
/// Contá cuántas veces sale cada palabra. Sin importar mayúsculas y con cualquier cantidad de espacios.
/// contarPalabras('Pupusa pupusa  café') devuelve {'pupusa': 2, 'café': 1}.
Map<String, int> contarPalabras(String texto) {
  // TODO: split(RegExp(r'\s+')) parte por uno o más espacios.
  throw UnimplementedError('TODO ejercicio 6');
}

/// Ejercicio 7
/// Juntá los ingredientes de todas las recetas sin repetir. Limpiá espacios y pasalos a minúscula.
Set<String> ingredientesUnicos(List<List<String>> recetas) {
  // TODO: un Set no guarda repetidos.
  throw UnimplementedError('TODO ejercicio 7');
}

/// Ejercicio 8
/// Recibís ventas por producto. Devolvé los nombres de los [cuantos] más vendidos, de mayor a menor.
/// Si dos venden igual, va primero el que viene antes en orden alfabético.
List<String> masVendidos(Map<String, int> ventas, int cuantos) {
  // TODO: entries, sort y take.
  throw UnimplementedError('TODO ejercicio 8');
}
