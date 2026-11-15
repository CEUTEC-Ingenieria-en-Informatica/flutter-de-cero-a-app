import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/05_layout/ejercicios.dart';

Widget enApp(Widget hijo) => MaterialApp(home: Scaffold(body: hijo));

/// Cambia el tamaño de la pantalla de prueba y lo devuelve a la normalidad al terminar.
void usarPantalla(WidgetTester tester, Size tamano) {
  tester.view.physicalSize = tamano;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  group('Módulo 05 · Layout', () {
    testWidgets('ejercicio 1: FilaProducto empuja el precio a la derecha', (tester) async {
      usarPantalla(tester, const Size(400, 800));
      await tester.pumpWidget(enApp(const Column(children: [FilaProducto(nombre: 'Revuelta', precio: 25)])));

      expect(find.text('Revuelta'), findsOneWidget);
      expect(find.text('L 25.00'), findsOneWidget);
      expect(find.ancestor(of: find.text('Revuelta'), matching: find.byType(Expanded)), findsOneWidget);

      final bordePrecio = tester.getTopRight(find.text('L 25.00')).dx;
      expect(bordePrecio, 400 - 16, reason: 'El precio termina a 16 del borde derecho');
      expect(tester.getTopLeft(find.text('Revuelta')).dx, 16);
    });

    testWidgets('ejercicio 2: ListaContactos vacía', (tester) async {
      await tester.pumpWidget(enApp(const ListaContactos(nombres: [])));
      expect(find.text('Sin contactos'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('ejercicio 2: ListaContactos con muchos nombres', (tester) async {
      final nombres = [for (var i = 0; i < 60; i++) 'contacto $i'];
      await tester.pumpWidget(enApp(ListaContactos(nombres: ['ana', 'Beto', ...nombres])));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.widgetWithText(ListTile, 'ana'), findsOneWidget);
      expect(find.descendant(of: find.byType(CircleAvatar), matching: find.text('A')), findsOneWidget);
      expect(find.descendant(of: find.byType(CircleAvatar), matching: find.text('B')), findsOneWidget);

      // ListView.builder solo construye lo que se ve: el último todavía no existe.
      expect(find.text('contacto 59'), findsNothing);
      await tester.scrollUntilVisible(find.text('contacto 59'), 300);
      expect(find.text('contacto 59'), findsOneWidget);
    });

    testWidgets('ejercicio 3: PerfilConInsignia', (tester) async {
      await tester.pumpWidget(enApp(const Center(child: PerfilConInsignia())));

      expect(find.byType(Stack), findsWidgets);
      final avatar = find.byType(CircleAvatar);
      expect(avatar, findsOneWidget);
      expect(tester.getSize(avatar), const Size(80, 80));
      expect(find.ancestor(of: find.byIcon(Icons.verified), matching: find.byType(Positioned)),
          findsOneWidget);
      expect(tester.getBottomRight(find.byIcon(Icons.verified)), tester.getBottomRight(avatar));
    });

    testWidgets('ejercicio 4: PanelResponsivo en pantalla ancha', (tester) async {
      usarPantalla(tester, const Size(900, 600));
      await tester.pumpWidget(enApp(const PanelResponsivo(izquierda: Text('Menú'), derecha: Text('Pedido'))));

      final menu = tester.getTopLeft(find.text('Menú'));
      final pedido = tester.getTopLeft(find.text('Pedido'));
      expect(pedido.dy, menu.dy, reason: 'Lado a lado: misma altura');
      expect(pedido.dx, 450, reason: 'Cada mitad mide 450 con Expanded');
    });

    testWidgets('ejercicio 4: PanelResponsivo en teléfono', (tester) async {
      usarPantalla(tester, const Size(390, 800));
      await tester.pumpWidget(enApp(const PanelResponsivo(izquierda: Text('Menú'), derecha: Text('Pedido'))));

      final menu = tester.getTopLeft(find.text('Menú'));
      final pedido = tester.getTopLeft(find.text('Pedido'));
      expect(pedido.dy, greaterThan(menu.dy), reason: 'Una debajo de la otra');
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('ejercicio 5: CuadriculaCategorias en 2 columnas', (tester) async {
      await tester.pumpWidget(enApp(const CuadriculaCategorias(categorias: ['Pupusas', 'Bebidas', 'Postres'])));

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(3));
      final a = tester.getCenter(find.text('Pupusas'));
      final b = tester.getCenter(find.text('Bebidas'));
      final c = tester.getCenter(find.text('Postres'));
      expect(b.dy, a.dy);
      expect(b.dx, greaterThan(a.dx));
      expect(c.dx, a.dx);
      expect(c.dy, greaterThan(a.dy));
    });
  });
}
