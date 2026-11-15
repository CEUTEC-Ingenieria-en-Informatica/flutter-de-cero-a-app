import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/11_tests/ejercicios.dart';

void main() {
  group('Módulo 11 · Tests', () {
    group('ejercicio 1: estaAbierto', () {
      // 16 de noviembre de 2026 es lunes y 22 de noviembre de 2026 es domingo.
      test('entre semana', () {
        expect(estaAbierto(DateTime(2026, 11, 16, 6, 59)), isFalse);
        expect(estaAbierto(DateTime(2026, 11, 16, 7, 0)), isTrue);
        expect(estaAbierto(DateTime(2026, 11, 16, 13, 30)), isTrue);
        expect(estaAbierto(DateTime(2026, 11, 16, 20, 59)), isTrue);
        expect(estaAbierto(DateTime(2026, 11, 16, 21, 0)), isFalse);
      });

      test('sábado', () {
        expect(estaAbierto(DateTime(2026, 11, 21, 20, 0)), isTrue);
      });

      test('domingo', () {
        expect(estaAbierto(DateTime(2026, 11, 22, 7, 30)), isFalse);
        expect(estaAbierto(DateTime(2026, 11, 22, 8, 0)), isTrue);
        expect(estaAbierto(DateTime(2026, 11, 22, 13, 59)), isTrue);
        expect(estaAbierto(DateTime(2026, 11, 22, 14, 0)), isFalse);
        expect(estaAbierto(DateTime(2026, 11, 22, 19, 0)), isFalse);
      });
    });

    test('ejercicio 2: SaludoDelDia con reloj inyectado', () {
      String saludoALas(int hora) => SaludoDelDia(ahora: () => DateTime(2026, 1, 1, hora)).saludo();

      expect(saludoALas(6), 'Buenos días');
      expect(saludoALas(11), 'Buenos días');
      expect(saludoALas(12), 'Buenas tardes');
      expect(saludoALas(17), 'Buenas tardes');
      expect(saludoALas(18), 'Buenas noches');
      expect(saludoALas(23), 'Buenas noches');
      expect(SaludoDelDia().saludo(), isNotEmpty, reason: 'Sin reloj usa la hora de verdad');
    });

    test('ejercicio 3: desgloseVuelto', () {
      expect(desgloseVuelto(75, 100), {20: 1, 5: 1});
      expect(desgloseVuelto(130, 500), {200: 1, 100: 1, 50: 1, 20: 1});
      expect(desgloseVuelto(1, 1000), {500: 1, 200: 2, 50: 1, 20: 2, 5: 1, 2: 2});
      expect(desgloseVuelto(100, 100), isEmpty, reason: 'Pagó exacto: no hay vuelto');
      expect(() => desgloseVuelto(100, 99), throwsArgumentError);
    });

    testWidgets('ejercicio 4: CampoBusqueda espera a que dejés de escribir', (tester) async {
      final busquedas = <String>[];
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: CampoBusqueda(alBuscar: busquedas.add)),
      ));

      expect(find.widgetWithText(TextField, 'Buscar'), findsOneWidget);
      final campo = find.byType(TextField);

      await tester.enterText(campo, 'pu');
      await tester.pump(const Duration(milliseconds: 200));
      await tester.enterText(campo, 'pupu');
      await tester.pump(const Duration(milliseconds: 200));
      expect(busquedas, isEmpty, reason: 'Todavía no pasan 300 ms desde la última tecla');

      await tester.enterText(campo, ' pupusa ');
      await tester.pump(const Duration(milliseconds: 299));
      expect(busquedas, isEmpty);
      await tester.pump(const Duration(milliseconds: 1));
      expect(busquedas, ['pupusa'], reason: 'Una sola búsqueda, con el último texto limpio');

      await tester.pump(const Duration(seconds: 1));
      expect(busquedas, hasLength(1));
    });

    testWidgets('ejercicio 4: si se cierra la pantalla, no busca', (tester) async {
      final busquedas = <String>[];
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: CampoBusqueda(alBuscar: busquedas.add)),
      ));
      await tester.enterText(find.byType(TextField), 'queso');
      expect(find.byType(TextField), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: Text('otra pantalla')));
      await tester.pump(const Duration(seconds: 1));
      expect(busquedas, isEmpty, reason: 'Cancelá el Timer en dispose');
    });
  });
}
