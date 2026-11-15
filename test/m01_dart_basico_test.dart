import 'package:flutter_test/flutter_test.dart';

import '../modulos/01_dart_basico/ejercicios.dart';

void main() {
  group('Módulo 01 · Dart básico', () {
    test('ejercicio 1: saludo limpia espacios', () {
      expect(saludo('Marta'), 'Hola, Marta');
      expect(saludo('  Marta '), 'Hola, Marta');
      expect(saludo('   '), 'Hola, desconocido');
      expect(saludo(''), 'Hola, desconocido');
    });

    test('ejercicio 2: formatoLempiras usa dos decimales', () {
      expect(formatoLempiras(35), 'L 35.00');
      expect(formatoLempiras(12.5), 'L 12.50');
      expect(formatoLempiras(0), 'L 0.00');
      expect(formatoLempiras(99.999), 'L 100.00');
    });

    test('ejercicio 3: precioConIsv suma 15 % y redondea', () {
      expect(precioConIsv(100), 115.0);
      expect(precioConIsv(19.99), 22.99);
      expect(precioConIsv(0), 0);
    });

    test('ejercicio 4: clasificarNota respeta los rangos', () {
      expect(clasificarNota(100), 'Excelente');
      expect(clasificarNota(90), 'Excelente');
      expect(clasificarNota(89), 'Muy bien');
      expect(clasificarNota(80), 'Muy bien');
      expect(clasificarNota(70), 'Bien');
      expect(clasificarNota(69), 'Reprobado');
      expect(clasificarNota(0), 'Reprobado');
      expect(clasificarNota(-1), 'Nota inválida');
      expect(clasificarNota(101), 'Nota inválida');
    });

    test('ejercicio 5: sumarHasta', () {
      expect(sumarHasta(4), 10);
      expect(sumarHasta(1), 1);
      expect(sumarHasta(100), 5050);
      expect(sumarHasta(0), 0);
      expect(sumarHasta(-5), 0);
    });

    test('ejercicio 6: tablaDeMultiplicar', () {
      final tabla = tablaDeMultiplicar(3);
      final lineas = tabla.split('\n');
      expect(lineas, hasLength(10));
      expect(lineas.first, '3 x 1 = 3');
      expect(lineas[4], '3 x 5 = 15');
      expect(lineas.last, '3 x 10 = 30');
      expect(tabla.endsWith('\n'), isFalse);
    });

    test('ejercicio 7: diaDeLaSemana', () {
      expect(diaDeLaSemana(1), 'lunes');
      expect(diaDeLaSemana(3), 'miércoles');
      expect(diaDeLaSemana(6), 'sábado');
      expect(diaDeLaSemana(7), 'domingo');
      expect(diaDeLaSemana(0), 'no existe');
      expect(diaDeLaSemana(8), 'no existe');
    });
  });
}
