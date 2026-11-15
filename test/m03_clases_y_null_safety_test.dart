import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';

import '../modulos/03_clases_y_null_safety/ejercicios.dart';

void main() {
  group('Módulo 03 · Clases y null safety', () {
    test('ejercicio 1: Producto valida, limpia y copia', () {
      final horchata = Producto('  Horchata ', 20);
      expect(horchata.nombre, 'Horchata');
      expect(horchata.etiqueta, 'Horchata, L 20.00');

      final grande = horchata.copiarCon(precio: 30);
      expect(grande.nombre, 'Horchata');
      expect(grande.precio, 30);
      expect(horchata.precio, 20, reason: 'copiarCon no debe cambiar el original');
      expect(horchata.copiarCon(nombre: 'Café').etiqueta, 'Café, L 20.00');

      expect(() => Producto('   ', 10), throwsArgumentError);
      expect(() => Producto('Agua', -1), throwsArgumentError);
    });

    test('ejercicio 2: Cuenta protege su saldo', () {
      final cuenta = Cuenta('Rosa');
      expect(cuenta.saldo, 0);
      cuenta.depositar(500);
      expect(cuenta.saldo, 500);
      expect(cuenta.retirar(200), isTrue);
      expect(cuenta.saldo, 300);
      expect(cuenta.retirar(1000), isFalse);
      expect(cuenta.retirar(0), isFalse);
      expect(cuenta.saldo, 300);
      expect(() => cuenta.depositar(0), throwsArgumentError);
      expect(() => cuenta.depositar(-5), throwsArgumentError);
    });

    test('ejercicio 3: nombreParaMostrar', () {
      expect(nombreParaMostrar('Chepe', 'José'), 'Chepe');
      expect(nombreParaMostrar(' Chepe ', 'José'), 'Chepe');
      expect(nombreParaMostrar(null, 'José'), 'José');
      expect(nombreParaMostrar('  ', 'José'), 'José');
    });

    test('ejercicio 4: largoSeguro', () {
      expect(largoSeguro('hola'), 4);
      expect(largoSeguro(''), 0);
      expect(largoSeguro(null), 0);
    });

    test('ejercicio 5: figuras con herencia', () {
      expect(Rectangulo(3, 4).area, 12);
      expect(Circulo(1).area, closeTo(math.pi, 0.0001));
      expect(areaTotal([Rectangulo(2, 5), Circulo(2)]), closeTo(10 + 4 * math.pi, 0.0001));
      expect(areaTotal([]), 0);
    });

    test('ejercicio 6: Cliente.desdeMapa', () {
      final completo = Cliente.desdeMapa({'nombre': 'Lupita', 'telefono': '9999 0000', 'puntos': 12});
      expect(completo.nombre, 'Lupita');
      expect(completo.telefono, '9999 0000');
      expect(completo.puntos, 12);
      expect(completo.tieneTelefono, isTrue);

      final minimo = Cliente.desdeMapa({'nombre': ' Toño ', 'puntos': 'muchos'});
      expect(minimo.nombre, 'Toño');
      expect(minimo.telefono, isNull);
      expect(minimo.puntos, 0);
      expect(minimo.tieneTelefono, isFalse);

      expect(() => Cliente.desdeMapa({}), throwsFormatException);
      expect(() => Cliente.desdeMapa({'nombre': 42}), throwsFormatException);
      expect(() => Cliente.desdeMapa({'nombre': ''}), throwsFormatException);
    });
  });
}
