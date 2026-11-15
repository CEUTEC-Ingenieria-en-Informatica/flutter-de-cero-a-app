import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/04_widgets/ejercicios.dart';

/// Envuelve un widget en lo mínimo para que se pueda dibujar.
Widget enApp(Widget hijo) => MaterialApp(home: Scaffold(body: hijo));

void main() {
  group('Módulo 04 · Widgets', () {
    testWidgets('ejercicio 1: TarjetaSaludo', (tester) async {
      await tester.pumpWidget(enApp(const TarjetaSaludo(nombre: 'Karla')));

      expect(find.text('Hola, Karla'), findsOneWidget);
      expect(find.byIcon(Icons.waving_hand), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(
        find.descendant(of: find.byType(Card), matching: find.byType(Row)),
        findsOneWidget,
        reason: 'El ícono y el texto van en un Row dentro de la Card',
      );
    });

    testWidgets('ejercicio 2: EtiquetaPrecio con precio', (tester) async {
      await tester.pumpWidget(enApp(const EtiquetaPrecio(precio: 35)));
      expect(find.text('L 35.00'), findsOneWidget);
      expect(find.text('Gratis'), findsNothing);
    });

    testWidgets('ejercicio 2: EtiquetaPrecio gratis en verde', (tester) async {
      await tester.pumpWidget(enApp(const EtiquetaPrecio(precio: 0)));
      final texto = tester.widget<Text>(find.text('Gratis'));
      expect(texto.style?.color, Colors.green);
      expect(find.text('L 0.00'), findsNothing);
    });

    testWidgets('ejercicio 3: BotonAccion llama al callback', (tester) async {
      var toques = 0;
      await tester.pumpWidget(enApp(BotonAccion(texto: 'Pedir', alPresionar: () => toques++)));

      expect(find.widgetWithText(ElevatedButton, 'Pedir'), findsOneWidget);
      await tester.tap(find.text('Pedir'));
      await tester.tap(find.text('Pedir'));
      expect(toques, 2);
    });

    testWidgets('ejercicio 4: PantallaInicio', (tester) async {
      var toques = 0;
      await tester.pumpWidget(MaterialApp(home: PantallaInicio(alPresionarMas: () => toques++)));

      expect(find.widgetWithText(AppBar, 'Mi primera app'), findsOneWidget);
      expect(
        find.descendant(of: find.byType(Center), matching: find.text('Bienvenido a Flutter')),
        findsOneWidget,
      );
      await tester.tap(find.byType(FloatingActionButton));
      expect(toques, 1);
      expect(find.descendant(of: find.byType(FloatingActionButton), matching: find.byIcon(Icons.add)),
          findsOneWidget);
    });

    testWidgets('ejercicio 5: Insignia', (tester) async {
      await tester.pumpWidget(enApp(const Insignia(texto: 'Nuevo', color: Colors.orange)));

      final texto = tester.widget<Text>(find.text('Nuevo'));
      expect(texto.style?.color, Colors.white);

      final contenedor = tester.widget<Container>(
        find.ancestor(of: find.text('Nuevo'), matching: find.byType(Container)).first,
      );
      final decoracion = contenedor.decoration as BoxDecoration?;
      expect(decoracion, isNotNull, reason: 'Usá BoxDecoration en el Container');
      expect(decoracion!.color, Colors.orange);
      expect(decoracion.borderRadius, BorderRadius.circular(12));
    });
  });
}
