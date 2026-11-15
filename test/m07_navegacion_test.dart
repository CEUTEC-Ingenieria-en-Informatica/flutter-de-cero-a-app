import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/07_navegacion/ejercicios.dart';

void main() {
  group('Módulo 07 · Navegación', () {
    testWidgets('ejercicio 1: ir al detalle y volver', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PantallaLista(platos: ['Baleada', 'Sopa de caracol'])));

      await tester.tap(find.text('Baleada'));
      await tester.pumpAndSettle(); // espera a que termine la animación
      expect(find.text('Detalle de Baleada'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Baleada'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Detalle de Baleada'), findsNothing);
      expect(find.text('Sopa de caracol'), findsOneWidget);
    });

    testWidgets('ejercicio 2: elegir un tamaño devuelve el dato', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Center(child: BotonTamano()))));
      expect(find.text('Tamaño: ninguno'), findsOneWidget);

      await tester.tap(find.text('Elegir tamaño'));
      await tester.pumpAndSettle();
      expect(find.text('Mediano'), findsOneWidget, reason: 'Se abrió la pantalla de tamaños');

      await tester.tap(find.text('Grande'));
      await tester.pumpAndSettle();
      expect(find.text('Tamaño: Grande'), findsOneWidget);
    });

    testWidgets('ejercicio 2: volver sin elegir no cambia nada', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Center(child: BotonTamano()))));

      await tester.tap(find.text('Elegir tamaño'));
      await tester.pumpAndSettle();
      expect(find.text('Pequeño'), findsOneWidget, reason: 'Se abrió la pantalla de tamaños');
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Tamaño: ninguno'), findsOneWidget);
    });

    testWidgets('ejercicio 3: rutas con nombre', (tester) async {
      await tester.pumpWidget(const AppConRutas());

      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.routes?.keys, containsAll(['/', '/acerca']));

      await tester.tap(find.text('Ver más'));
      await tester.pumpAndSettle();
      expect(find.text('Hecho por la comunidad'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Acerca de'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Ver más'), findsOneWidget);
    });

    testWidgets('ejercicio 4: pushReplacement no deja volver', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PantallaBienvenida()));

      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();
      expect(find.text('Ya estás adentro'), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Inicio'), findsOneWidget);
      expect(find.text('Entrar'), findsNothing);
      expect(find.byType(BackButton), findsNothing, reason: 'No hay pantalla anterior a la cual volver');

      final contexto = tester.element(find.text('Ya estás adentro'));
      expect(Navigator.canPop(contexto), isFalse);
    });
  });
}
