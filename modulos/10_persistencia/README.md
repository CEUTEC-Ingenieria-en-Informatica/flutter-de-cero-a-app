# 10 · Persistencia local

Cerrás la app y al abrirla otra vez tu carrito sigue ahí, el modo oscuro sigue activo y tus notas no se perdieron. Eso es persistencia local: guardar datos en el teléfono. Hay varias formas de hacerlo y elegir mal duele (guardar contraseñas en texto plano, meter mil registros en preferencias). Este módulo te da el mapa de opciones y te pone a practicar la idea de fondo sin depender de ningún plugin.

## Lo que vas a aprender

1. Las opciones para guardar datos en Flutter y cuándo usar cada una.
2. Por qué conviene esconder el almacenamiento detrás de una interfaz.
3. Leer y escribir archivos con `dart:io`.
4. Guardar listas de objetos como JSON.
5. Qué hacer cuando lo guardado está dañado.

## El mapa de opciones

| Opción | Qué guarda | Cuándo |
|---|---|---|
| [shared_preferences](https://pub.dev/packages/shared_preferences) | Pares clave y valor sencillos | Ajustes: tema, idioma, si ya vio la bienvenida |
| Archivos con [path_provider](https://pub.dev/packages/path_provider) y `dart:io` | Lo que quieras: JSON, imágenes, PDF | Documentos o datos que no necesitan búsquedas |
| [sqflite](https://pub.dev/packages/sqflite) o [drift](https://pub.dev/packages/drift) | Tablas SQL con SQLite | Muchos registros, búsquedas, filtros, relaciones |
| [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) | Textos cifrados con el llavero del sistema | Tokens de sesión y secretos. Nunca en preferencias |

Todas esas son plugins: hablan con Android, iOS o el escritorio por debajo. Funcionan perfecto en la app, pero en un test normal no hay teléfono, así que hay que simularlas. Por eso este curso practica con una interfaz propia y deja los plugins para cuando armés tu app.

## Esconder el almacenamiento detrás de una interfaz

```dart
abstract class Almacen {
  Future<String?> leer(String clave);
  Future<void> guardar(String clave, String valor);
  Future<void> borrar(String clave);
}
```

Tu lógica (notas, preferencias) solo conoce `Almacen`. Después podés tener:

1. `AlmacenEnMemoria` para tests: rápido y se borra solo.
2. `AlmacenArchivo` con `dart:io`: lo hacés en el ejercicio 1.
3. Uno con shared_preferences en tu app real, escrito en diez líneas.

Es la misma idea del cliente HTTP falso del módulo 09. Si un día cambiás de shared_preferences a SQLite, tu lógica ni se entera.

## Archivos con dart:io

```dart
final archivo = File('${carpeta.path}${Platform.pathSeparator}notas.txt');

if (await archivo.exists()) {
  final texto = await archivo.readAsString();
}
await carpeta.create(recursive: true);
await archivo.writeAsString('hola');
await archivo.delete();
```

`Platform.pathSeparator` es `\` en Windows y `/` en los demás. En una app real la carpeta la da `getApplicationDocumentsDirectory()` de path_provider; en los tests, `Directory.systemTemp.createTemp()`.

Ojo: `dart:io` no existe en Flutter web. Si tu app también va para web, usá shared_preferences, que funciona en todos lados.

## Guardar listas: JSON otra vez

Lo que aprendiste en el módulo 09 sirve igual aquí:

```dart
final texto = jsonEncode(notas.map((n) => n.toJson()).toList());
await almacen.guardar('notas', texto);

final lista = jsonDecode(texto) as List<dynamic>;
final notas = lista.map((e) => Nota.fromJson(e as Map<String, dynamic>)).toList();
```

Leer, cambiar en memoria y guardar todo de vuelta. Para unas cuantas decenas de notas es perfecto. Para miles, o si necesitás buscar, pasate a SQLite.

## Cuando lo guardado está dañado

Un día la app se cierra a medio guardar, o cambiaste la forma de `Nota` y lo viejo ya no calza. Si `cargar` revienta, la app no abre nunca más hasta que el usuario la desinstale. Por eso:

```dart
try {
  // decodificar y convertir
} on FormatException {
  return []; // no era JSON
} on TypeError {
  return []; // era JSON pero con otra forma
}
```

Devolver vacío es lo más simple. En apps serias también se registra el error y, si los datos importan, se guarda una copia del archivo dañado antes de pisarlo.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) es un programa de consola que cuenta cuántas veces lo corriste:

```
dart run modulos/10_persistencia/ejemplo.dart
```

1. Arma la ruta del archivo en la carpeta temporal del sistema.
2. Si el archivo existe, lo lee y lo decodifica. Si está dañado, avisa y empieza de cero.
3. Suma uno, guarda la fecha y escribe todo de vuelta como JSON.

Corrélo tres veces. Después abrí el archivo, escribile basura y corrélo otra vez.

## Errores comunes

1. Guardar tokens o contraseñas en shared_preferences o en un archivo normal. Cualquiera con acceso al teléfono los lee. Usá almacenamiento seguro.
2. Usar preferencias como base de datos. Sirven para ajustes, no para cientos de registros.
3. No manejar datos dañados. Una vez que pasa, la app no vuelve a abrir.
4. Llamar al plugin desde todos lados. Escondelo detrás de una interfaz y probás sin teléfono.
5. Olvidar el `await` al guardar. La app sigue, se cierra, y lo que creías guardado no llegó al disco.
6. Rutas armadas con `/` a mano. En Windows fallan. Usá `Platform.pathSeparator` o el paquete path.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart):

```
flutter test test/m10_persistencia_test.dart
```

Los tests crean una carpeta temporal nueva para cada prueba y la borran al terminar, así no dejan basura en tu compu.

| # | Qué practica |
|---|---|
| 1 | Implementar la interfaz con archivos de verdad |
| 2 | Guardar una lista como JSON y sobrevivir a datos dañados |
| 3 | Preferencias con valores por defecto y un contador persistente |

Solución en [`soluciones/10_persistencia`](../../soluciones/10_persistencia/ejercicios.dart).

## Repaso

1. ¿Dónde guardarías: el idioma elegido, 3,000 productos con búsqueda, el token de sesión, una foto de perfil?
2. ¿Por qué tu lógica depende de `Almacen` y no directamente de shared_preferences?
3. ¿Qué pasa si `cargar` revienta con datos dañados?
4. ¿Por qué `dart:io` no sirve en web?
5. ¿Qué ganás con `AlmacenEnMemoria` en los tests?

## Para seguir leyendo

1. [Persistencia en Flutter, recetario](https://docs.flutter.dev/cookbook/persistence)
2. [Guardar pares clave y valor](https://docs.flutter.dev/cookbook/persistence/key-value)
3. [Leer y escribir archivos](https://docs.flutter.dev/cookbook/persistence/reading-writing-files)
4. [SQLite en Flutter](https://docs.flutter.dev/cookbook/persistence/sqlite)
