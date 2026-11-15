// Módulo 01 · Dart básico · ejercicios
//
// Cambiá cada `throw UnimplementedError(...)` por tu código.
// Para revisar solo este módulo: flutter test test/m01_dart_basico_test.dart

/// Ejercicio 1
/// Devolvé 'Hola, ' seguido del nombre, sin espacios sobrantes al inicio ni al final.
/// Si el nombre viene vacío o solo con espacios, devolvé 'Hola, desconocido'.
/// Ejemplo: saludo('  Marta ') devuelve 'Hola, Marta'.
String saludo(String nombre) {
  // TODO: usá trim() e isEmpty.
  throw UnimplementedError('TODO ejercicio 1');
}

/// Ejercicio 2
/// Escribí un monto en lempiras con dos decimales: formatoLempiras(35) devuelve 'L 35.00'.
String formatoLempiras(double monto) {
  // TODO: buscá toStringAsFixed.
  throw UnimplementedError('TODO ejercicio 2');
}

/// Ejercicio 3
/// Sumale el 15 % de ISV a un precio y redondeá a 2 decimales.
/// Ejemplo: precioConIsv(100) devuelve 115.0 y precioConIsv(19.99) devuelve 22.99.
double precioConIsv(double precio) {
  // TODO
  throw UnimplementedError('TODO ejercicio 3');
}

/// Ejercicio 4
/// De 90 a 100 'Excelente', de 80 a 89 'Muy bien', de 70 a 79 'Bien' y de 0 a 69 'Reprobado'.
/// Cualquier número fuera de 0 a 100 es 'Nota inválida'.
String clasificarNota(int nota) {
  // TODO: el orden de los if importa.
  throw UnimplementedError('TODO ejercicio 4');
}

/// Ejercicio 5
/// Sumá los números de 1 hasta n con un ciclo for. Si n es menor que 1, devolvé 0.
/// Ejemplo: sumarHasta(4) devuelve 10 (1 + 2 + 3 + 4).
int sumarHasta(int n) {
  // TODO
  throw UnimplementedError('TODO ejercicio 5');
}

/// Ejercicio 6
/// Armá la tabla de multiplicar de n, del 1 al 10, una línea por fila y sin salto al final.
/// La primera línea de la tabla del 3 es '3 x 1 = 3' y la última '3 x 10 = 30'.
String tablaDeMultiplicar(int n) {
  // TODO: juntá las líneas con join('\n').
  throw UnimplementedError('TODO ejercicio 6');
}

/// Ejercicio 7
/// Con una expresión switch, convertí 1 a 7 en 'lunes' ... 'domingo' (en minúscula y con tildes).
/// Cualquier otro número devuelve 'no existe'.
String diaDeLaSemana(int numero) {
  // TODO
  throw UnimplementedError('TODO ejercicio 7');
}
