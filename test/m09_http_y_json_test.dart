import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../modulos/09_http_y_json/ejercicios.dart';

/// Cliente falso: no sale a internet. Devuelve las respuestas que le preparamos, en orden,
/// y anota qué direcciones le pidieron.
class ClienteFalso implements ClienteHttp {
  ClienteFalso(this.respuestas);

  final List<FutureOr<RespuestaHttp>> respuestas;
  final pedidas = <Uri>[];

  @override
  Future<RespuestaHttp> get(Uri url) async {
    pedidas.add(url);
    return respuestas.removeAt(0);
  }
}

const menuJson = '''
{
  "platos": [
    {"id": 1, "nombre": "Revuelta", "precio": 25},
    {"id": 2, "nombre": "Loroco con queso", "precio": 28.5, "disponible": false}
  ]
}
''';

void main() {
  group('Módulo 09 · HTTP y JSON', () {
    test('ejercicio 1: Plato.fromJson y toJson', () {
      final plato = Plato.fromJson({'id': 7, 'nombre': 'Horchata', 'precio': 20});
      expect(plato.id, 7);
      expect(plato.nombre, 'Horchata');
      expect(plato.precio, 20.0);
      expect(plato.disponible, isTrue);

      final agotado = Plato.fromJson({'id': 8, 'nombre': 'Café', 'precio': 15.5, 'disponible': false});
      expect(agotado.precio, 15.5);
      expect(agotado.disponible, isFalse);

      expect(agotado.toJson(), {'id': 8, 'nombre': 'Café', 'precio': 15.5, 'disponible': false});
      // Ida y vuelta por texto JSON.
      final copia = Plato.fromJson(jsonDecode(jsonEncode(plato.toJson())) as Map<String, dynamic>);
      expect(copia.nombre, plato.nombre);
      expect(copia.precio, plato.precio);
    });

    test('ejercicio 2: parsearMenu', () {
      final platos = parsearMenu(menuJson);
      expect(platos, hasLength(2));
      expect(platos.first.nombre, 'Revuelta');
      expect(platos.last.precio, 28.5);
      expect(platos.last.disponible, isFalse);
      expect(parsearMenu('{"platos": []}'), isEmpty);
    });

    test('ejercicio 3: ServicioMenu con respuesta 200', () async {
      final cliente = ClienteFalso([const RespuestaHttp(200, menuJson)]);
      final menu = await ServicioMenu(cliente).obtenerMenu();
      expect(menu.map((p) => p.nombre), ['Revuelta', 'Loroco con queso']);
      expect(cliente.pedidas, [ServicioMenu.direccion]);
    });

    test('ejercicio 3: ServicioMenu con error del servidor', () async {
      final cliente = ClienteFalso([const RespuestaHttp(500, 'se cayó')]);
      await expectLater(
        ServicioMenu(cliente).obtenerMenu(),
        throwsA(isA<ErrorDeServidor>().having((e) => e.estado, 'estado', 500)),
      );
    });

    testWidgets('ejercicio 4: carga, muestra la lista y marca agotados', (tester) async {
      final pendiente = Completer<RespuestaHttp>();
      final cliente = ClienteFalso([pendiente.future]);
      await tester.pumpWidget(MaterialApp(home: PantallaMenu(servicio: ServicioMenu(cliente))));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      pendiente.complete(const RespuestaHttp(200, menuJson));
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.widgetWithText(ListTile, 'Revuelta'), findsOneWidget);
      expect(find.text('L 25.00'), findsOneWidget);
      expect(find.text('L 28.50'), findsOneWidget);
      expect(find.text('Agotado'), findsOneWidget);
      expect(cliente.pedidas, hasLength(1), reason: 'Pedí el menú una sola vez, no en cada build');
    });

    testWidgets('ejercicio 4: error y reintentar', (tester) async {
      final cliente = ClienteFalso([
        const RespuestaHttp(503, ''),
        const RespuestaHttp(200, menuJson),
      ]);
      await tester.pumpWidget(MaterialApp(home: PantallaMenu(servicio: ServicioMenu(cliente))));
      await tester.pumpAndSettle();

      expect(find.text('No se pudo cargar el menú'), findsOneWidget);
      await tester.tap(find.text('Reintentar'));
      await tester.pumpAndSettle();

      expect(find.text('No se pudo cargar el menú'), findsNothing);
      expect(find.text('Revuelta'), findsOneWidget);
      expect(cliente.pedidas, hasLength(2));
    });
  });
}
