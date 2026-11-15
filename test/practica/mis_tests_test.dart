// Tus propios tests (módulo 11, ejercicio 3).
//
// Este archivo es tuyo: el curso no lo revisa, pero `flutter test` lo corre junto con todo lo demás.
// Correlo solo con: flutter test test/practica/mis_tests_test.dart
import 'package:flutter_test/flutter_test.dart';

import '../../modulos/11_tests/ejercicios.dart';

void main() {
  group('Mis tests de desgloseVuelto', () {
    test('un vuelto de 50 es un billete de 50', () {
      expect(desgloseVuelto(50, 100), {50: 1});
    });

    // Escribí aquí abajo los tests que encuentren los errores de desgloseVuelto.
    // Ideas: ¿qué pasa si el cliente paga exacto? ¿Y si el vuelto es 20?
    // Primero el test tiene que salir en rojo con la función como está. Después la arreglás.
  });
}
