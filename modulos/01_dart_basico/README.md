# 01 · Dart básico

Flutter se escribe en Dart. Antes de pintar botones conviene que el lenguaje no te asuste: variables, tipos, decisiones y ciclos. Si ya programaste en Java, C# o JavaScript, vas a reconocer casi todo; lo nuevo está en los detalles (null safety, `final`, el `switch` moderno), y esos detalles son los que después te salvan de errores raros en la app.

## Lo que vas a aprender

1. Declarar variables con `var`, `final` y `const`, y cuándo usar cada una.
2. Los tipos que más vas a usar: `int`, `double`, `String`, `bool`.
3. Armar textos con interpolación.
4. Tomar decisiones con `if` y con `switch`.
5. Repetir con `for` y `while`.

## Variables: var, final y const

```dart
var pupusas = 3;          // Dart deduce que es int. Se puede cambiar.
final cliente = 'Rosa';   // Se asigna una vez y ya. El valor se conoce al correr.
const isv = 0.15;         // Constante de compilación. Nunca cambia.
String sucursal = 'Centro'; // También podés escribir el tipo a mano.
```

La regla práctica: empezá con `final`. Si después necesitás cambiar el valor, pasalo a `var`. Si el valor está escrito tal cual en el código y nunca cambia (como el 15 % del ISV), usá `const`. En Flutter esto importa: los widgets `const` se crean una sola vez y la app trabaja menos.

Dart es de tipado estático: una variable que nació `int` no puede guardar después un `String`.

```dart
var cantidad = 3;
cantidad = 'tres'; // Error al compilar: A value of type 'String' can't be assigned to int
```

## Tipos básicos

| Tipo | Ejemplo | Para qué |
|---|---|---|
| `int` | `12` | Cantidades enteras: pupusas, edad, unidades |
| `double` | `25.50` | Montos, medidas, porcentajes |
| `num` | `3` o `3.5` | Cuando aceptás cualquiera de los dos |
| `String` | `'Hola'` | Texto, con comillas simples o dobles |
| `bool` | `true` | Sí o no |

Un detalle: `5 / 2` da `2.5` (siempre `double`). Si querés división entera usá `5 ~/ 2`, que da `2`. El residuo es `5 % 2`.

## Textos e interpolación

```dart
final nombre = 'Rosa';
final total = 57.5;
print('Hola, $nombre');                          // Hola, Rosa
print('Total: L ${total.toStringAsFixed(2)}');  // Total: L 57.50
```

Con `$variable` metés una variable; con `${expresión}` metés cualquier cosa que dé un valor. Algunos métodos que vas a usar a diario: `trim()` quita espacios de los extremos, `toUpperCase()`, `contains()`, `split()` y `isEmpty`.

## Decisiones

```dart
if (nota >= 90) {
  print('Excelente');
} else if (nota >= 70) {
  print('Pasó');
} else {
  print('Reprobado');
}
```

Desde Dart 3, `switch` también puede ser una expresión que devuelve un valor, con patrones:

```dart
final turno = switch (hora) {
  < 12 => 'mañana',
  < 18 => 'tarde',
  _ => 'noche', // el guion bajo atrapa todo lo demás
};
```

Es más corto que una cadena de `if` y el compilador te avisa si te falta un caso.

## Ciclos

```dart
for (var i = 1; i <= 3; i++) {
  print('Pupusa $i');
}

var restantes = 3;
while (restantes > 0) {
  restantes--;
}
```

Para recorrer listas vas a usar más `for (final x in lista)`, que se ve en el módulo 02.

## Ejemplo explicado

Abrí [`ejemplo.dart`](ejemplo.dart) y corrélo:

```
dart run modulos/01_dart_basico/ejemplo.dart
```

Lo que pasa, en orden:

1. Declara `pupusas` con `var` porque después le suma 2. `precioUnidad` es `final` porque no cambia en todo el programa, e `isv` es `const` porque es un número fijo.
2. Calcula subtotal y total. Fijate que `pupusas * precioUnidad` da `double` aunque `pupusas` sea `int`: al mezclar, Dart sube a `double`.
3. Imprime con `toStringAsFixed(2)` para que el monto salga con dos decimales, como en un recibo.
4. Usa `if` para decidir si regala curtido, un `for` para contar, y un `switch` de expresión para el turno.

Cambiale cosas: poné 10 pupusas, cambiá la hora a 9 y mirá qué imprime.

## Errores comunes

1. Usar `var` para todo. Funciona, pero perdés la ayuda del compilador cuando algo no debía cambiar. Preferí `final`.
2. Comparar textos sin limpiar. `'Marta ' == 'Marta'` es `false` por el espacio. Usá `trim()` cuando el dato viene de un usuario.
3. Olvidar las llaves en la interpolación: `'$total.toStringAsFixed(2)'` imprime el número y luego el texto `.toStringAsFixed(2)`. Lo correcto es `'${total.toStringAsFixed(2)}'`.
4. Confundir `/` con `~/`. Si esperás un entero, `/` te va a dar `double`.
5. Redondear plata a lo loco. `toStringAsFixed` sirve para mostrar; si necesitás el número redondeado, multiplicá por 100, usá `round()` y dividí entre 100.
6. Poner los `if` en desorden. Si preguntás primero `nota >= 70` y después `nota >= 90`, el 95 entra al primero.

## Ejercicios

Están en [`ejercicios.dart`](ejercicios.dart). Cada función tiene un `throw UnimplementedError` que tenés que cambiar por tu código. Los tests de este módulo están en `test/m01_dart_basico_test.dart`:

```
flutter test test/m01_dart_basico_test.dart
```

Al principio todos salen en rojo. Esa es la idea: vas resolviendo uno por uno hasta que todo pase. Si te trabás más de 15 minutos en uno, mirá [`soluciones/01_dart_basico`](../../soluciones/01_dart_basico/ejercicios.dart), cerralo y escribilo otra vez sin verlo.

| # | Qué practica |
|---|---|
| 1 | `trim`, `isEmpty` e interpolación |
| 2 | `toStringAsFixed` |
| 3 | Operaciones con `double` y redondeo |
| 4 | `if` en el orden correcto y validar rangos |
| 5 | Ciclo `for` acumulando |
| 6 | Armar texto en varias líneas con `join` |
| 7 | `switch` como expresión |

## Repaso

1. ¿Qué diferencia hay entre `final` y `const`? Pensá en un valor que pueda ser `final` pero no `const`.
2. ¿Qué devuelve `7 ~/ 2`? ¿Y `7 / 2`?
3. ¿Por qué `'Hola, $nombre.length'` no imprime el largo del nombre?
4. En un `switch` de expresión, ¿para qué sirve `_`?
5. Si una función recibe un nombre escrito por el usuario, ¿qué limpiarías antes de usarlo?

## Para seguir leyendo

1. [Tour del lenguaje Dart: variables](https://dart.dev/language/variables)
2. [Tipos integrados](https://dart.dev/language/built-in-types)
3. [Ramas y switch con patrones](https://dart.dev/language/branches)
4. [Ciclos](https://dart.dev/language/loops)
5. [DartPad](https://dartpad.dev), para probar código en el navegador sin instalar nada
