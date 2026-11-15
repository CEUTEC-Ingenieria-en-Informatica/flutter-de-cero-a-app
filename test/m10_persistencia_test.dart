import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../modulos/10_persistencia/ejercicios.dart';

void main() {
  group('Módulo 10 · Persistencia local', () {
    late Directory carpeta;

    setUp(() async {
      // Una carpeta temporal nueva para cada test. Se borra al final.
      carpeta = await Directory.systemTemp.createTemp('flutter_de_cero_');
    });

    tearDown(() async {
      if (await carpeta.exists()) {
        await carpeta.delete(recursive: true);
      }
    });

    test('ejercicio 1: AlmacenArchivo guarda, lee y borra', () async {
      final subcarpeta = Directory('${carpeta.path}${Platform.pathSeparator}datos');
      final almacen = AlmacenArchivo(subcarpeta);

      expect(await almacen.leer('saludo'), isNull);
      await almacen.guardar('saludo', 'Hola, comunidad');
      expect(await almacen.leer('saludo'), 'Hola, comunidad');
      expect(File('${subcarpeta.path}${Platform.pathSeparator}saludo.txt').existsSync(), isTrue);

      await almacen.guardar('saludo', 'Otro texto');
      expect(await almacen.leer('saludo'), 'Otro texto');

      await almacen.borrar('saludo');
      expect(await almacen.leer('saludo'), isNull);
      await almacen.borrar('no_existe'); // no debe fallar
    });

    test('ejercicio 1: lo guardado sobrevive a otra instancia', () async {
      await AlmacenArchivo(carpeta).guardar('tema', 'oscuro');
      // Como si la app se cerrara y se abriera de nuevo.
      expect(await AlmacenArchivo(carpeta).leer('tema'), 'oscuro');
    });

    test('ejercicio 2: RepositorioNotas', () async {
      final almacen = AlmacenEnMemoria();
      final repo = RepositorioNotas(almacen);

      expect(await repo.cargar(), isEmpty);
      await repo.agregar(const Nota(id: 'a', texto: 'Comprar masa'));
      await repo.agregar(const Nota(id: 'b', texto: 'Practicar layout'));

      final otraVez = await RepositorioNotas(almacen).cargar();
      expect(otraVez.map((n) => n.texto), ['Comprar masa', 'Practicar layout']);

      await repo.borrar('a');
      expect((await repo.cargar()).map((n) => n.id), ['b']);
    });

    test('ejercicio 2: datos dañados no revientan la app', () async {
      final almacen = AlmacenEnMemoria();
      final repo = RepositorioNotas(almacen);

      await almacen.guardar(RepositorioNotas.clave, 'esto no es json');
      expect(await repo.cargar(), isEmpty);

      await almacen.guardar(RepositorioNotas.clave, '{"no": "es una lista"}');
      expect(await repo.cargar(), isEmpty);

      await almacen.guardar(RepositorioNotas.clave, '[{"id": 1}]');
      expect(await repo.cargar(), isEmpty);
    });

    test('ejercicio 2: funciona igual con archivos', () async {
      final repo = RepositorioNotas(AlmacenArchivo(carpeta));
      await repo.agregar(const Nota(id: 'x', texto: 'Hola'));
      expect((await RepositorioNotas(AlmacenArchivo(carpeta)).cargar()).single.texto, 'Hola');
    });

    test('ejercicio 3: Preferencias', () async {
      final almacen = AlmacenEnMemoria();
      final prefs = Preferencias(almacen);

      expect(await prefs.temaOscuro(), isFalse);
      await prefs.guardarTemaOscuro(true);
      expect(await Preferencias(almacen).temaOscuro(), isTrue);
      await prefs.guardarTemaOscuro(false);
      expect(await prefs.temaOscuro(), isFalse);

      expect(await prefs.vecesAbierta(), 0);
      expect(await prefs.registrarApertura(), 1);
      expect(await prefs.registrarApertura(), 2);
      expect(await Preferencias(almacen).vecesAbierta(), 2);

      await almacen.guardar('aperturas', 'muchas');
      expect(await prefs.vecesAbierta(), 0);
    });
  });
}
