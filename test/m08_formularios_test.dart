import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/08_formularios/ejercicios.dart';

void main() {
  group('Módulo 08 · Formularios y validación', () {
    test('ejercicio 1: validarRequerido', () {
      expect(validarRequerido('Ana'), isNull);
      expect(validarRequerido(''), 'Este campo es obligatorio');
      expect(validarRequerido('   '), 'Este campo es obligatorio');
      expect(validarRequerido(null, campo: 'El nombre'), 'El nombre es obligatorio');
    });

    test('ejercicio 2: validarCorreo', () {
      expect(validarCorreo('rosa@ejemplo.hn'), isNull);
      expect(validarCorreo('  rosa@ejemplo.com '), isNull);
      expect(validarCorreo(''), 'El correo es obligatorio');
      expect(validarCorreo('rosa'), 'Correo no válido');
      expect(validarCorreo('rosa@ejemplo'), 'Correo no válido');
      expect(validarCorreo('ro sa@ejemplo.com'), 'Correo no válido');
      expect(validarCorreo('@ejemplo.com'), 'Correo no válido');
    });

    test('ejercicio 3: teléfono de Honduras', () {
      expect(normalizarTelefono('9876 5432'), '98765432');
      expect(normalizarTelefono('9876-5432'), '98765432');
      expect(validarTelefonoHn('9876-5432'), isNull);
      expect(validarTelefonoHn('2234 5678'), isNull);
      expect(validarTelefonoHn(''), 'El teléfono es obligatorio');
      expect(validarTelefonoHn('1234 5678'), 'Teléfono no válido (8 dígitos)');
      expect(validarTelefonoHn('9876 543'), 'Teléfono no válido (8 dígitos)');
      expect(validarTelefonoHn('9876 54321'), 'Teléfono no válido (8 dígitos)');
      expect(validarTelefonoHn('9876abcd'), 'Teléfono no válido (8 dígitos)');
    });

    test('ejercicio 4: validarCantidad', () {
      expect(validarCantidad('3'), isNull);
      expect(validarCantidad(' 50 '), isNull);
      expect(validarCantidad(''), 'Escribí un número');
      expect(validarCantidad(null), 'Escribí un número');
      expect(validarCantidad('dos'), 'Escribí un número');
      expect(validarCantidad('2.5'), 'Escribí un número');
      expect(validarCantidad('0'), 'Entre 1 y 50');
      expect(validarCantidad('51'), 'Entre 1 y 50');
    });

    testWidgets('ejercicio 5: el formulario muestra errores y no envía', (tester) async {
      DatosPedido? enviado;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FormularioPedido(alEnviar: (d) => enviado = d)),
      ));

      await tester.tap(find.text('Enviar pedido'));
      await tester.pump();
      expect(find.text('El nombre es obligatorio'), findsOneWidget);
      expect(find.text('El teléfono es obligatorio'), findsOneWidget);
      expect(find.text('Escribí un número'), findsOneWidget);
      expect(enviado, isNull);

      await tester.enterText(find.byKey(const Key('nombre')), 'Rosa');
      await tester.enterText(find.byKey(const Key('telefono')), '1234');
      await tester.enterText(find.byKey(const Key('cantidad')), '3');
      await tester.tap(find.text('Enviar pedido'));
      await tester.pump();
      expect(find.text('El nombre es obligatorio'), findsNothing);
      expect(find.text('Teléfono no válido (8 dígitos)'), findsOneWidget);
      expect(enviado, isNull);
    });

    testWidgets('ejercicio 5: el formulario envía datos limpios', (tester) async {
      DatosPedido? enviado;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: FormularioPedido(alEnviar: (d) => enviado = d)),
      ));

      await tester.enterText(find.byKey(const Key('nombre')), '  Rosa Mejía ');
      await tester.enterText(find.byKey(const Key('telefono')), '9876-5432');
      await tester.enterText(find.byKey(const Key('cantidad')), '12');
      await tester.tap(find.text('Enviar pedido'));
      await tester.pump();

      expect(enviado, isNotNull);
      expect(enviado!.nombre, 'Rosa Mejía');
      expect(enviado!.telefono, '98765432');
      expect(enviado!.cantidad, 12);
    });
  });
}
