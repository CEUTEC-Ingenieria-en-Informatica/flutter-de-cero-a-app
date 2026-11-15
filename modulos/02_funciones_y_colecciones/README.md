# 02 · Funciones y colecciones

En una app casi todo es una lista de algo: productos, mensajes, pedidos, contactos. Y casi todo lo que hacés con esas listas es filtrar, transformar o sumar. Este módulo te enseña a hacerlo con funciones cortas y claras, que es justo como se arma después la lista de una pantalla en Flutter.

## Lo que vas a aprender

1. Escribir funciones con parámetros posicionales, opcionales y con nombre.
2. Funciones flecha y funciones anónimas.
3. Las tres colecciones de Dart: `List`, `Map` y `Set`.
4. Transformar colecciones con `map`, `where`, `fold`, `sort` y `take`.
5. `if` y `for` dentro de una colección.

## Funciones

```dart
double subtotal(int cantidad, double precio) {
  return cantidad * precio;
}

String moneda(double monto) => 'L ${monto.toStringAsFixed(2)}';
```

La segunda es una función flecha: `=> expresión` equivale a `{ return expresión; }`. Usala cuando el cuerpo cabe en una línea.

### Tres formas de recibir parámetros

```dart
// Posicionales: importa el orden.
double area(double base, double altura) => base * altura;

// Opcionales posicionales, entre corchetes, con valor por defecto.
double descuento(double precio, [double porcentaje = 10]) => precio * porcentaje / 100;

// Con nombre, entre llaves. Se leen solos al llamarlos.
String etiqueta({required String nombre, int existencia = 0}) => '$nombre: $existencia';

etiqueta(nombre: 'Horchata', existencia: 4);
```

Flutter usa parámetros con nombre en todos lados: `Text('Hola', style: ...)`, `Padding(padding: ..., child: ...)`. Por eso vale la pena entenderlos aquí.

`required` obliga a mandar el parámetro. Sin `required`, un parámetro con nombre necesita valor por defecto o ser nullable (eso lo ves en el módulo 03).

### Funciones como valores

En Dart una función se puede guardar en una variable o pasar a otra función:

```dart
final esCaro = (double precio) => precio > 24;
print(esCaro(28)); // true
```

Esto es lo que usás cada vez que escribís `onPressed: () { ... }` en un botón.

## Colecciones

| Colección | Se escribe | Cuándo |
|---|---|---|
| `List` | `['queso', 'loroco']` | Importa el orden o puede haber repetidos |
| `Map` | `{'queso': 22.0}` | Buscás un valor por su clave |
| `Set` | `{'queso', 'loroco'}` | No querés repetidos y te importa si algo está o no |

```dart
final pedidos = <String>['revuelta', 'queso', 'revuelta'];
final precios = <String, double>{'revuelta': 25, 'queso': 22};
final sabores = pedidos.toSet(); // {revuelta, queso}

print(precios['queso']);    // 22.0
print(precios['chicharrón']); // null, porque no existe esa clave
```

Ojo con el último: leer una clave que no existe en un `Map` devuelve `null`, no un error. Por eso se escribe `precios['x'] ?? 0`.

## Transformar sin ciclos

```dart
final montos = pedidos.map((sabor) => precios[sabor] ?? 0).toList();
final caros  = pedidos.where((sabor) => (precios[sabor] ?? 0) > 24).toList();
final total  = montos.fold(0.0, (suma, m) => suma + m);
```

1. `map` transforma cada elemento y te da otro iterable del mismo largo.
2. `where` deja pasar solo los que cumplen la condición.
3. `fold` arranca con un valor inicial y va acumulando.
4. `toList()` convierte el resultado en lista. `map` y `where` son perezosos: no hacen nada hasta que alguien recorre el resultado.

Para ordenar, `sort` recibe una función que compara dos elementos y devuelve negativo, cero o positivo. `sort` cambia la lista original, por eso muchas veces se hace sobre una copia.

```dart
final copia = [...pedidos]..sort((a, b) => a.compareTo(b));
```

Los dos puntos (`..`) son la cascada: llaman a `sort` y devuelven la misma lista.

### if y for dentro de una colección

```dart
final combo = ['revuelta', 'queso', if (conBebida) 'horchata'];
final dobles = [for (final p in combo) '$p x2'];
```

En Flutter esto es oro: `children: [Titulo(), if (cargando) Spinner(), for (final p in productos) FilaProducto(p)]`.

## Ejemplo explicado

Corré [`ejemplo.dart`](ejemplo.dart):

```
dart run modulos/02_funciones_y_colecciones/ejemplo.dart
```

1. Arriba hay tres funciones: una normal, una flecha y una con parámetros con nombre.
2. En `main` se arma un pedido como `List`, un menú de precios como `Map` y se saca un `Set` con los sabores distintos.
3. Con `map` se convierte cada sabor en su precio, con `where` se filtran los caros y con `fold` se suma.
4. Al final recorre el `Map` con `entries` y arma un combo usando `if` y `for` dentro de la lista.

Probá agregar un sabor que no está en `precios` y mirá cómo `?? 0` evita el error.

## Errores comunes

1. Olvidar `toList()`. `map` devuelve un `Iterable`, no una `List`, y si tu función promete `List<String>` el compilador se queja.
2. Esperar que `map` cambie la lista original. No la toca: crea una nueva.
3. Usar `sort` y luego sorprenderse de que la lista original cambió. Si no querés eso, ordená una copia.
4. `fold(0, ...)` con montos `double`: el `0` es `int` y Dart infiere mal el tipo. Usá `0.0`.
5. Leer `mapa[clave]` y tratarlo como si nunca fuera `null`.
6. Partir texto con `split(' ')` cuando puede haber dos espacios seguidos: salen palabras vacías. Usá `split(RegExp(r'\s+'))` y filtrá vacíos.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart). Revisalos con:

```
flutter test test/m02_funciones_y_colecciones_test.dart
```

| # | Qué practica |
|---|---|
| 1 | `fold` |
| 2 | `map` sin tocar la original |
| 3 | `where` |
| 4 | Parámetros con nombre |
| 5 | Parámetros opcionales posicionales |
| 6 | `Map` como contador |
| 7 | `Set` y `for` anidado |
| 8 | `entries`, `sort` con desempate y `take` |

Solución en [`soluciones/02_funciones_y_colecciones`](../../soluciones/02_funciones_y_colecciones/ejercicios.dart).

## Repaso

1. ¿Cuándo preferís un parámetro con nombre sobre uno posicional?
2. ¿Qué devuelve `{'a': 1}['b']`?
3. ¿Por qué `map` no hace nada hasta que llamás `toList()` o lo recorrés?
4. Tenés una lista de correos con repetidos y querés saber cuántos distintos hay. ¿Qué colección usás?
5. ¿Qué hace `..` en `lista..sort()`?

## Para seguir leyendo

1. [Funciones en Dart](https://dart.dev/language/functions)
2. [Colecciones](https://dart.dev/language/collections)
3. [Tutorial de iterables](https://dart.dev/libraries/collections/iterables)
