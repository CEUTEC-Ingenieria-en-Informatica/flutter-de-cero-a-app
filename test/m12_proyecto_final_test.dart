import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/12_proyecto_final/modelos.dart';
import '../modulos/12_proyecto_final/pantallas.dart';
import '../modulos/12_proyecto_final/pedido.dart';

final revuelta = productoPorId('revuelta');
final queso = productoPorId('queso');
final horchata = productoPorId('horchata');

/// Pantalla alta para que todo el menú quepa sin hacer scroll.
void pantallaAlta(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

String textoDe(WidgetTester tester, String key) => tester.widget<Text>(find.byKey(Key(key))).data!;

void main() {
  group('Módulo 12 · Pedido', () {
    test('agregar, quitar, orden y avisos', () {
      final pedido = Pedido();
      var avisos = 0;
      pedido.addListener(() => avisos++);

      expect(pedido.estaVacio, isTrue);
      pedido.agregar(horchata);
      pedido.agregar(revuelta);
      pedido.agregar(revuelta);
      expect(avisos, 3);
      expect(pedido.cantidadDe(revuelta), 2);
      expect(pedido.cantidadDe(queso), 0);
      expect(pedido.totalArticulos, 3);
      expect(pedido.lineas.map((l) => l.$1.id), ['horchata', 'revuelta']);

      pedido.quitar(horchata);
      expect(pedido.lineas.map((l) => l.$1.id), ['revuelta'], reason: 'En 0 sale del pedido');
      pedido.quitar(queso);
      expect(avisos, 4, reason: 'Quitar lo que no está no avisa');

      pedido.vaciar();
      expect(pedido.estaVacio, isTrue);
      expect(avisos, 5);
      pedido.vaciar();
      expect(avisos, 5);
    });

    test('montos sin promoción', () {
      final pedido = Pedido()
        ..agregar(revuelta)
        ..agregar(revuelta)
        ..agregar(horchata);
      expect(pedido.subtotal, 70);
      expect(pedido.descuento, 0);
      expect(pedido.isv, 10.5);
      expect(pedido.total, 80.5);
      expect(pedido.resumenParaCocina(), '2 x Revuelta\n1 x Horchata');
    });

    test('promoción desde 12 pupusas, sin contar bebidas', () {
      final pedido = Pedido();
      for (var i = 0; i < 6; i++) {
        pedido.agregar(revuelta);
      }
      for (var i = 0; i < 5; i++) {
        pedido.agregar(queso);
      }
      pedido
        ..agregar(horchata)
        ..agregar(horchata);
      expect(pedido.totalPupusas, 11);
      expect(pedido.descuento, 0, reason: '11 pupusas y 2 bebidas no llegan a la promo');

      pedido.agregar(queso);
      expect(pedido.totalPupusas, 12);
      expect(pedido.subtotal, 322);
      expect(pedido.descuento, 28.2, reason: '10 % de 282, lo que suman las pupusas');
      expect(pedido.isv, 44.07);
      expect(pedido.total, 337.87);
    });
  });

  group('Módulo 12 · Pantallas', () {
    testWidgets('el menú suma, resta y cuenta', (tester) async {
      pantallaAlta(tester);
      final pedido = Pedido();
      await tester.pumpWidget(AppPupuseria(pedido: pedido));

      expect(find.widgetWithText(AppBar, 'El Comal Alegre'), findsOneWidget);
      expect(find.text('Pupusas'), findsOneWidget);
      expect(find.text('Bebidas'), findsOneWidget);
      expect(find.text('Loroco con queso'), findsOneWidget);
      expect(find.text('L 28.00'), findsOneWidget);
      expect(textoDe(tester, 'cantidad_revuelta'), '0');
      expect(tester.widget<IconButton>(find.byKey(const Key('quitar_revuelta'))).onPressed, isNull);

      await tester.tap(find.byKey(const Key('agregar_revuelta')));
      await tester.tap(find.byKey(const Key('agregar_revuelta')));
      await tester.tap(find.byKey(const Key('agregar_horchata')));
      await tester.pump();
      expect(textoDe(tester, 'cantidad_revuelta'), '2');
      expect(textoDe(tester, 'contador_pedido'), '3');

      await tester.tap(find.byKey(const Key('quitar_revuelta')));
      await tester.pump();
      expect(textoDe(tester, 'cantidad_revuelta'), '1');
      expect(pedido.totalArticulos, 2);
    });

    testWidgets('pedido vacío', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PantallaPedido(pedido: Pedido())));
      expect(find.widgetWithText(AppBar, 'Tu pedido'), findsOneWidget);
      expect(find.text('Todavía no agregaste nada'), findsOneWidget);
    });

    testWidgets('el pedido muestra la promoción', (tester) async {
      pantallaAlta(tester);
      final pedido = Pedido();
      for (var i = 0; i < 12; i++) {
        pedido.agregar(revuelta);
      }
      await tester.pumpWidget(MaterialApp(home: PantallaPedido(pedido: pedido)));

      expect(find.text('12 x Revuelta'), findsOneWidget);
      expect(textoDe(tester, 'subtotal'), 'Subtotal: L 300.00');
      expect(textoDe(tester, 'descuento'), 'Descuento: L 30.00');
      expect(textoDe(tester, 'isv'), 'ISV (15 %): L 40.50');
      expect(textoDe(tester, 'total'), 'Total: L 310.50');
    });

    testWidgets('de principio a fin', (tester) async {
      pantallaAlta(tester);
      final pedido = Pedido();
      await tester.pumpWidget(AppPupuseria(pedido: pedido));

      await tester.tap(find.byKey(const Key('agregar_revuelta')));
      await tester.tap(find.byKey(const Key('agregar_horchata')));
      await tester.pump();

      await tester.tap(find.byKey(const Key('ver_pedido')));
      await tester.pumpAndSettle();
      expect(find.text('1 x Revuelta'), findsOneWidget);
      expect(find.byKey(const Key('descuento')), findsNothing);
      expect(textoDe(tester, 'total'), 'Total: L 51.75');

      await tester.tap(find.text('Confirmar pedido'));
      await tester.pump();
      expect(find.text('Escribí tu nombre'), findsOneWidget);
      expect(find.text('Teléfono de 8 dígitos'), findsOneWidget);
      expect(pedido.estaVacio, isFalse);

      await tester.enterText(find.byKey(const Key('nombre')), ' Rosa ');
      await tester.enterText(find.byKey(const Key('telefono')), '9876-5432');
      await tester.tap(find.text('Confirmar pedido'));
      await tester.pumpAndSettle();

      expect(find.text('Gracias, Rosa'), findsOneWidget);
      expect(find.text('Total a pagar: L 51.75'), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
      expect(pedido.estaVacio, isTrue);

      await tester.tap(find.text('Hacer otro pedido'));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'El Comal Alegre'), findsOneWidget);
      expect(textoDe(tester, 'cantidad_revuelta'), '0');
    });
  });
}
