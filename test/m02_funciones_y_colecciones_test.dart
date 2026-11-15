import 'package:flutter_test/flutter_test.dart';

import '../modulos/02_funciones_y_colecciones/ejercicios.dart';

void main() {
  group('Módulo 02 · Funciones y colecciones', () {
    test('ejercicio 1: sumarPrecios', () {
      expect(sumarPrecios([25, 22, 28]), 75);
      expect(sumarPrecios([10.5]), 10.5);
      expect(sumarPrecios([]), 0);
    });

    test('ejercicio 2: enMayuscula no cambia la original', () {
      final original = ['ana', 'Luis'];
      expect(enMayuscula(original), ['ANA', 'LUIS']);
      expect(original, ['ana', 'Luis']);
      expect(enMayuscula([]), isEmpty);
    });

    test('ejercicio 3: soloPares', () {
      expect(soloPares([1, 2, 3, 4, 10, 11]), [2, 4, 10]);
      expect(soloPares([1, 3]), isEmpty);
    });

    test('ejercicio 4: describirPlato con parámetros con nombre', () {
      expect(describirPlato('Baleada', precio: 35), 'Baleada: L 35.00');
      expect(describirPlato('Sopa', precio: 80, picante: true), 'Sopa: L 80.00 (picante)');
      expect(describirPlato('Agua'), 'Agua: L 0.00');
    });

    test('ejercicio 5: aplicarDescuento con opcional', () {
      expect(aplicarDescuento(200), 180);
      expect(aplicarDescuento(200, 25), 150);
      expect(aplicarDescuento(50, 0), 50);
    });

    test('ejercicio 6: contarPalabras', () {
      expect(contarPalabras('Pupusa pupusa  café'), {'pupusa': 2, 'café': 1});
      expect(contarPalabras('  uno dos\nuno '), {'uno': 2, 'dos': 1});
      expect(contarPalabras(''), isEmpty);
    });

    test('ejercicio 7: ingredientesUnicos', () {
      final resultado = ingredientesUnicos([
        ['Masa', 'Queso', 'Frijol'],
        ['masa', ' queso ', 'Loroco'],
        [],
      ]);
      expect(resultado, {'masa', 'queso', 'frijol', 'loroco'});
    });

    test('ejercicio 8: masVendidos', () {
      final ventas = {'queso': 40, 'revuelta': 55, 'frijol': 40, 'loroco': 12};
      expect(masVendidos(ventas, 2), ['revuelta', 'frijol']);
      expect(masVendidos(ventas, 3), ['revuelta', 'frijol', 'queso']);
      expect(masVendidos(ventas, 10), hasLength(4));
      expect(masVendidos({}, 3), isEmpty);
    });
  });
}
