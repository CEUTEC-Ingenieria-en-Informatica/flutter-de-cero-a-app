import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/06_estado/ejercicios.dart';

Widget enApp(Widget hijo) => MaterialApp(home: Scaffold(body: Center(child: hijo)));

String valorDelContador(WidgetTester tester) => tester.widget<Text>(find.byKey(const Key('valor'))).data!;

void main() {
  group('Módulo 06 · Estado', () {
    testWidgets('ejercicio 1: Contador suma, resta y no baja de 0', (tester) async {
      await tester.pumpWidget(enApp(const Contador()));
      expect(valorDelContador(tester), '0');

      final restar = find.widgetWithIcon(IconButton, Icons.remove);
      expect(tester.widget<IconButton>(restar).onPressed, isNull, reason: 'En 0, restar está desactivado');

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(valorDelContador(tester), '2');

      await tester.tap(restar);
      await tester.pump();
      expect(valorDelContador(tester), '1');
      await tester.tap(restar);
      await tester.pump();
      await tester.tap(restar);
      await tester.pump();
      expect(valorDelContador(tester), '0');
    });

    test('ejercicio 2: ModeloCarrito calcula y avisa', () {
      final carrito = ModeloCarrito();
      var avisos = 0;
      carrito.addListener(() => avisos++);

      expect(carrito.cantidad, 0);
      expect(carrito.total, 0);

      carrito.agregar('Revuelta', 25);
      carrito.agregar('Horchata', 20);
      carrito.agregar('Revuelta', 25);
      expect(avisos, 3);
      expect(carrito.cantidad, 3);
      expect(carrito.total, 70);
      expect(carrito.articulos, ['Revuelta', 'Horchata', 'Revuelta']);
      expect(() => carrito.articulos.add('Trampa'), throwsUnsupportedError);

      carrito.quitar('Revuelta');
      expect(carrito.articulos, ['Horchata', 'Revuelta']);
      expect(avisos, 4);

      carrito.quitar('Café');
      expect(avisos, 4, reason: 'Si no quitó nada, no avisa');

      carrito.vaciar();
      expect(carrito.cantidad, 0);
      expect(avisos, 5);
      carrito.vaciar();
      expect(avisos, 5, reason: 'Vaciar algo vacío no avisa');
    });

    testWidgets('ejercicio 3: InterruptorTema en las dos direcciones', (tester) async {
      final oscuro = ValueNotifier(false);
      addTearDown(oscuro.dispose);
      await tester.pumpWidget(enApp(InterruptorTema(oscuro: oscuro)));

      expect(find.text('Modo claro'), findsOneWidget);
      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(oscuro.value, isTrue);
      expect(find.text('Modo oscuro'), findsOneWidget);

      oscuro.value = false;
      await tester.pump();
      expect(find.text('Modo claro'), findsOneWidget);
      expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    });

    testWidgets('ejercicio 4: ResumenCarrito escucha al modelo', (tester) async {
      final carrito = ModeloCarrito();
      addTearDown(carrito.dispose);
      await tester.pumpWidget(enApp(ResumenCarrito(carrito: carrito)));

      expect(find.text('Artículos: 0'), findsOneWidget);
      expect(find.text('Total: L 0.00'), findsOneWidget);
      expect(tester.widget<TextButton>(find.widgetWithText(TextButton, 'Vaciar')).onPressed, isNull);

      carrito.agregar('Queso', 22);
      carrito.agregar('Loroco con queso', 25);
      await tester.pump();
      expect(find.text('Artículos: 2'), findsOneWidget);
      expect(find.text('Total: L 47.00'), findsOneWidget);

      await tester.tap(find.text('Vaciar'));
      await tester.pump();
      expect(carrito.cantidad, 0);
      expect(find.text('Artículos: 0'), findsOneWidget);
    });
  });
}
