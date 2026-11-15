# 03 · Clases y null safety

En Flutter todo es una clase: cada pantalla, cada botón y cada dato que manejás (un producto, un usuario, un pedido). Y casi todos los errores de principiante en apps vienen de un valor que era `null` cuando no lo esperabas. Este módulo junta los dos temas porque van de la mano: diseñar bien tus clases es decidir qué puede faltar y qué no.

## Lo que vas a aprender

1. Crear clases con campos, constructores, getters y métodos.
2. Constructores con nombre y constructores `factory`.
3. Campos privados con guion bajo.
4. Herencia y clases abstractas.
5. Null safety: `?`, `??`, `?.`, `!` y la promoción de tipos.

## Una clase de cero

```dart
class Mascota {
  Mascota(this.nombre, {this.raza, int edad = 0}) : _edad = edad;

  final String nombre;
  final String? raza;
  int _edad;

  int get edad => _edad;
  void cumplirAnios() => _edad++;
}
```

Leela por partes:

1. `Mascota(this.nombre, ...)` es el constructor. `this.nombre` copia el argumento al campo sin escribir más.
2. Lo que va después de `:` es la lista de inicialización. Ahí se asignan campos antes de que el objeto exista del todo. Sirve para limpiar o convertir datos: `: nombre = nombre.trim()`.
3. `final String nombre` no cambia después de crear el objeto. En Flutter vas a ver que casi todos los campos de un widget son `final`.
4. `_edad` empieza con guion bajo, así que es privado: fuera de este archivo nadie lo puede tocar. Para leerlo desde afuera se ofrece el getter `edad`.

### Constructores con nombre y factory

```dart
Mascota.adoptada(String nombre) : this(nombre, raza: 'Criolla');

factory Cliente.desdeMapa(Map<String, Object?> datos) {
  // revisa, convierte y al final devuelve un Cliente
}
```

Un constructor con nombre es otra puerta de entrada con su propio nombre. `factory` es un constructor que puede tener lógica, revisar datos y decidir qué devolver. Es el patrón que vas a usar para leer JSON en el módulo 09 (`Producto.fromJson`).

## Herencia y clases abstractas

```dart
abstract class Figura {
  double get area;
}

class Rectangulo extends Figura {
  Rectangulo(this.ancho, this.alto);
  final double ancho;
  final double alto;

  @override
  double get area => ancho * alto;
}
```

`Figura` no se puede crear sola: solo dice que toda figura tiene área. Cada hija la calcula a su manera, y `@override` deja claro que estás reemplazando lo del padre. La ventaja: una función que recibe `List<Figura>` funciona con rectángulos, círculos y lo que inventés después. Así trabaja Flutter con `StatelessWidget` y `StatefulWidget`, que son clases que vos extendés.

## Null safety

Desde Dart 2.12 una variable no puede ser `null` a menos que lo digás con `?`.

```dart
String nombre = 'Rosa';  // nunca null
String? apodo;           // puede ser null, y arranca así
```

Las herramientas para trabajar con lo que puede faltar:

| Operador | Qué hace | Ejemplo |
|---|---|---|
| `?.` | Llama solo si no es null; si es null, da null | `apodo?.length` |
| `??` | Valor de respaldo si lo de la izquierda es null | `apodo ?? 'sin apodo'` |
| `??=` | Asigna solo si está en null | `apodo ??= 'Peluche'` |
| `!` | "Te juro que no es null". Si sí lo es, la app revienta | `apodo!.length` |

Dart además es listo: después de un `if (apodo != null)`, dentro del `if` ya trata a `apodo` como `String` normal. Eso se llama promoción de tipo. No funciona con campos de una clase que otro código podría cambiar; ahí copiá el campo a una variable local primero.

```dart
final limpio = apodo?.trim();
if (limpio == null || limpio.isEmpty) return nombre;
return limpio; // aquí limpio ya es String, no String?
```

Y `is` revisa el tipo de un valor que viene de afuera:

```dart
final puntos = datos['puntos'];
final seguro = puntos is int ? puntos : 0;
```

## Ejemplo explicado

Corré [`ejemplo.dart`](ejemplo.dart):

```
dart run modulos/03_clases_y_null_safety/ejemplo.dart
```

1. `Mascota` tiene un campo opcional `raza` y uno privado `_edad`.
2. `Mascota.adoptada` reutiliza el constructor principal y le pone raza "Criolla".
3. `Perro` hereda de `Mascota` con `super.nombre` (pasa el argumento directo al padre) y agrega `ladrar`.
4. Al final se juega con un `String?` que devuelve `apodoDe`: `?.` no revienta, `??` da respaldo y, dentro de `if (otro != null)`, Dart deja usar `toUpperCase()` sin `!`.

Probá quitarle el `?` a `raza` y mirá qué errores salen.

## Errores comunes

1. Usar `!` para callar al compilador. Funciona hasta que un día el valor sí es null y la app se cierra. Primero preguntate si de verdad puede faltar.
2. Hacer todo `String?` "por si acaso". Entonces todo tu código se llena de `??` y `!`. Si un campo siempre existe, que no sea nullable.
3. Esperar promoción de tipo en un campo de clase. `if (this.raza != null) raza.length` no compila. Copiá a una variable local.
4. Validar en un lugar que no corre siempre. Si la regla es "el precio no puede ser negativo", ponela en el constructor; así ningún objeto nace mal.
5. Olvidar `@override`. No es obligatorio, pero sin él no te enterás si escribiste mal el nombre del método que querías reemplazar.
6. Cambiar un objeto que otros comparten. Por eso existe `copiarCon` (en Flutter lo vas a ver como `copyWith`): creás uno nuevo con el cambio.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart):

```
flutter test test/m03_clases_y_null_safety_test.dart
```

| # | Qué practica |
|---|---|
| 1 | Lista de inicialización, validar en el constructor, getter, `copiarCon` |
| 2 | Campo privado y getter |
| 3 | `?.` con un texto que puede faltar |
| 4 | `?.` y `??` en una línea |
| 5 | Clase abstracta, herencia y `@override` |
| 6 | `factory`, `is` y valores opcionales desde un mapa |

Solución en [`soluciones/03_clases_y_null_safety`](../../soluciones/03_clases_y_null_safety/ejercicios.dart).

## Repaso

1. ¿Qué diferencia hay entre `String` y `String?`?
2. ¿Qué devuelve `null ?? 'hola'`? ¿Y `'adiós' ?? 'hola'`?
3. ¿Por qué un campo privado con getter es mejor que un campo público que cualquiera cambia?
4. ¿Para qué sirve un constructor `factory`?
5. Tenés `abstract class Pago { double get comision; }`. Inventá dos clases hijas.

## Para seguir leyendo

1. [Clases](https://dart.dev/language/classes)
2. [Constructores](https://dart.dev/language/constructors)
3. [Null safety](https://dart.dev/null-safety)
4. [Entender la null safety a fondo](https://dart.dev/null-safety/understanding-null-safety)
