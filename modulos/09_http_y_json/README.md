# 09 · HTTP y JSON

Casi toda app habla con un servidor: baja el menú, manda un pedido, revisa si hay mensajes nuevos. Eso significa tres cosas nuevas: esperar (la red tarda), convertir texto JSON en objetos de Dart, y prepararse para que algo falle (sin señal, servidor caído, datos raros). En este módulo hacés las tres, y además aprendés a probarlo todo sin tocar internet.

## Lo que vas a aprender

1. `Future`, `async` y `await`.
2. Qué es JSON y cómo pasar de texto a objetos con `jsonDecode` y `fromJson`.
3. Separar el cliente HTTP de tu lógica para poder probarla.
4. Mostrar carga, error y datos con `FutureBuilder`.
5. Las opciones reales para HTTP en Flutter.

## Esperar sin congelar la app

```dart
Future<List<Plato>> obtenerMenu() async {
  final respuesta = await cliente.get(direccion);
  return parsearMenu(respuesta.cuerpo);
}
```

Un `Future` es una promesa de un valor que llega después. `await` pausa esta función (no la app) hasta que llegue. Una función con `await` adentro se marca `async` y siempre devuelve un `Future`. Mientras tanto, la interfaz sigue respondiendo.

Si algo falla, el `Future` termina con error y `await` lo lanza como excepción. Se atrapa con `try` y `catch`, o lo deja pasar para que lo maneje quien llamó.

## JSON

JSON es texto con una forma que Dart entiende fácil:

```json
{"platos": [{"id": 1, "nombre": "Revuelta", "precio": 25}]}
```

```dart
import 'dart:convert';

final datos = jsonDecode(texto) as Map<String, dynamic>;
final lista = datos['platos'] as List<dynamic>;
```

`jsonDecode` devuelve `Map<String, dynamic>`, `List<dynamic>`, números, textos, `bool` o `null`. Con `dynamic` el compilador no te ayuda, así que lo convertís a tus propias clases cuanto antes:

```dart
factory Plato.fromJson(Map<String, dynamic> json) {
  return Plato(
    id: json['id'] as int,
    nombre: json['nombre'] as String,
    precio: (json['precio'] as num).toDouble(),
    disponible: json['disponible'] as bool? ?? true,
  );
}
```

Dos detalles que muerden: un precio `25` llega como `int` y `25.5` como `double`, por eso se lee como `num` y se pasa a `double`. Y un campo que puede no venir se lee como `bool?` con un valor de respaldo.

`toJson` hace el camino de vuelta, para mandar datos al servidor con `jsonEncode`.

En proyectos grandes, `fromJson` y `toJson` se generan con paquetes como json_serializable. Escribirlos a mano primero te enseña qué hacen esos paquetes.

## Separar el cliente: la clave para probar

```dart
abstract class ClienteHttp {
  Future<RespuestaHttp> get(Uri url);
}

class ServicioMenu {
  ServicioMenu(this.cliente);
  final ClienteHttp cliente;
  // ...
}
```

`ServicioMenu` no sabe si habla con internet o con un cliente falso. En la app le pasás uno real; en los tests, uno que responde lo que vos querés, al instante y sin red. Así podés probar el caso feliz, un error 500 y una respuesta lenta. Esto se llama inyección de dependencias y es la idea más útil de todo el módulo.

### Las opciones reales

| Opción | Cuándo |
|---|---|
| Paquete [http](https://pub.dev/packages/http) | Lo más común. Funciona en móvil, escritorio y web |
| Paquete [dio](https://pub.dev/packages/dio) | Cuando necesitás interceptores, reintentos o subir archivos con progreso |
| `HttpClient` de `dart:io` | Sin paquetes, pero no funciona en web |

Este curso no instala paquetes para que todo corra igual en cualquier compu. En tus apps usá `http`: con él, la interfaz `ClienteHttp` que armaste se implementa en pocas líneas. Sin paquetes, con `dart:io`, se vería así (sirve en Android, iOS y escritorio, no en web):

```dart
import 'dart:convert';
import 'dart:io';

class ClienteHttpIo implements ClienteHttp {
  final _cliente = HttpClient();

  @override
  Future<RespuestaHttp> get(Uri url) async {
    final pedido = await _cliente.getUrl(url);
    final respuesta = await pedido.close();
    final cuerpo = await respuesta.transform(utf8.decoder).join();
    return RespuestaHttp(respuesta.statusCode, cuerpo);
  }
}
```

## FutureBuilder

```dart
FutureBuilder<List<Plato>>(
  future: _menu, // creado en initState, NO aquí
  builder: (context, foto) {
    if (foto.connectionState != ConnectionState.done) return const CircularProgressIndicator();
    if (foto.hasError) return const Text('No se pudo cargar el menú');
    return ListaPlatos(foto.data!);
  },
)
```

Cada vez que el `Future` cambia de estado, se llama al `builder` con una "foto" (`AsyncSnapshot`) del momento. Tres casos siempre: cargando, error y datos.

El `Future` se crea en `initState` y se guarda. Si lo creás dentro de `build`, cada reconstrucción lanza un pedido nuevo al servidor. Los tests del ejercicio 4 revisan justo eso.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) muestra avisos de la comunidad:

```
flutter run -t modulos/09_http_y_json/ejemplo.dart
```

1. `Aviso.fromJson` convierte cada mapa a objeto, incluida la fecha con `DateTime.parse`.
2. `Fuente` es la interfaz. `FuenteSimulada` espera un segundo y devuelve JSON fijo, para que veás el indicador de carga. Para hablar con un servidor de verdad solo cambiás la fuente; la pantalla no se entera.
3. `cargarAvisos` usa la fuente, decodifica y convierte.
4. La pantalla guarda el `Future` en un campo `late final` (se crea una sola vez) y lo muestra con `FutureBuilder`.

Cambiá el JSON simulado para que le falte la fecha a un aviso y mirá cómo se ve el error.

## Errores comunes

1. Crear el `Future` dentro de `build`. Pedidos repetidos y parpadeo.
2. Olvidar el caso de error. Sin señal, la app se queda cargando para siempre o revienta.
3. `json['precio'] as double` cuando el servidor manda `25`. Revienta con "int is not a subtype of double". Usá `num`.
4. Usar `dynamic` por toda la app. Convertí a clases en la frontera, apenas llega el JSON.
5. Ignorar el código de estado. Un 404 o un 500 también trae cuerpo, y tratarlo como datos buenos da errores raros más adelante.
6. Reintentar con `setState(() => _menu = servicio.obtenerMenu())`. La flecha devuelve el `Future` y `setState` lanza "setState() callback argument returned a Future". Usá llaves: `setState(() { _menu = servicio.obtenerMenu(); })`.
7. Probar contra el servidor real. Los tests se vuelven lentos y fallan cuando no hay internet. Usá un cliente falso.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart):

```
flutter test test/m09_http_y_json_test.dart
```

Los tests traen un `ClienteFalso` que responde lo que se le prepara y anota cuántas veces lo llamaron. En el ejercicio 4 usan un `Completer` para que la respuesta tarde hasta que el test diga, y así ver el indicador de carga.

| # | Qué practica |
|---|---|
| 1 | `fromJson` y `toJson` con tipos que no siempre vienen igual |
| 2 | `jsonDecode` y convertir una lista |
| 3 | Un servicio que recibe el cliente y maneja el código de estado |
| 4 | `FutureBuilder` con carga, error, reintento y datos |

Solución en [`soluciones/09_http_y_json`](../../soluciones/09_http_y_json/ejercicios.dart).

## Repaso

1. ¿Qué hace `await` y por qué no congela la app?
2. ¿Por qué `fromJson` lee el precio como `num`?
3. ¿Qué ganás al recibir el cliente HTTP por el constructor?
4. ¿Qué pasa si creás el `Future` dentro de `build`?
5. Nombrá los tres estados que tu `FutureBuilder` siempre tiene que cubrir.

## Para seguir leyendo

1. [Programación asíncrona: futures, async y await](https://dart.dev/libraries/async/async-await)
2. [JSON en Flutter](https://docs.flutter.dev/data-and-backend/serialization/json)
3. [Traer datos de internet](https://docs.flutter.dev/cookbook/networking/fetch-data)
4. [Paquete http en pub.dev](https://pub.dev/packages/http)
