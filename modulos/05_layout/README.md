# 05 · Layout

Ya sabés crear widgets. Ahora toca acomodarlos: uno al lado del otro, uno encima del otro, con espacio, que se adapten a un teléfono angosto y a una pantalla ancha. Casi todos los "no se ve como en el diseño" y las famosas franjas amarillas y negras de overflow salen de no entender cómo mide Flutter. Este módulo arranca por ahí.

## Lo que vas a aprender

1. La regla de oro del layout en Flutter.
2. `Row`, `Column` y sus alineaciones.
3. `Expanded`, `Flexible`, `SizedBox`, `Padding` y `Center`.
4. Listas largas con `ListView.builder` y cuadrículas con `GridView`.
5. Encimar cosas con `Stack` y `Positioned`.
6. Pantallas que se adaptan con `LayoutBuilder`.

## La regla de oro

> Las restricciones bajan, los tamaños suben y el padre decide la posición.

1. El padre le dice a cada hijo: "podés medir entre tanto y tanto" (restricciones).
2. El hijo decide su tamaño dentro de ese rango y se lo devuelve al padre.
3. El padre lo coloca donde quiere.

Por eso un widget no puede decidir su posición solo, y por eso un `ListView` dentro de un `Column` revienta: el `Column` le dice "medí lo que querás de alto" y la lista, que puede ser infinita, no sabe qué hacer. La solución es darle un límite con `Expanded` o un `SizedBox` con alto.

## Row y Column

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // en el eje principal (horizontal en Row)
  crossAxisAlignment: CrossAxisAlignment.center,     // en el eje cruzado (vertical en Row)
  children: [Text('Revuelta'), Text('L 25.00')],
)
```

`Column` es lo mismo pero vertical. Los valores de `mainAxisAlignment` más usados: `start`, `center`, `end`, `spaceBetween`, `spaceAround` y `spaceEvenly`.

## Repartir el espacio: Expanded

```dart
Row(
  children: [
    Expanded(child: Text(nombre)), // se queda con todo lo que sobra
    Text('L 25.00'),               // mide lo que necesita
  ],
)
```

`Expanded` le dice al hijo: "ocupá el espacio que sobra". Si hay varios, se reparten según `flex` (por defecto 1 cada uno). `Flexible` es parecido pero deja que el hijo mida menos si no necesita todo. Un texto largo dentro de un `Row` sin `Expanded` es la causa número uno del overflow.

## Espacio

| Widget | Para qué |
|---|---|
| `Padding` | Espacio por dentro, alrededor de un hijo |
| `SizedBox(width: 8)` | Un hueco fijo entre dos widgets, o un tamaño fijo |
| `Center` | Centra al hijo en el espacio que tiene |
| `Spacer()` | Dentro de un `Row` o `Column`, un `Expanded` vacío que empuja |

`EdgeInsets.all(16)`, `EdgeInsets.symmetric(horizontal: 16, vertical: 8)` y `EdgeInsets.only(left: 8)` son las tres formas de decir cuánto espacio.

## Listas y cuadrículas

```dart
ListView.builder(
  itemCount: nombres.length,
  itemBuilder: (context, i) => ListTile(title: Text(nombres[i])),
)
```

`ListView.builder` construye solo las filas que se ven en pantalla. Con 10,000 contactos la app sigue fluida, porque nunca existen los 10,000 widgets a la vez. `ListView(children: [...])` los crea todos; sirve solo para listas cortas.

`ListTile` es la fila típica de Material: `leading` (izquierda), `title`, `subtitle` y `trailing` (derecha).

```dart
GridView.count(
  crossAxisCount: 2,
  children: [for (final c in categorias) Card(child: Center(child: Text(c)))],
)
```

## Stack: una cosa encima de otra

```dart
Stack(
  children: [
    CircleAvatar(radius: 40),
    Positioned(right: 0, bottom: 0, child: Icon(Icons.verified)),
  ],
)
```

El primer hijo queda abajo y el último arriba. Los hijos sin `Positioned` deciden el tamaño del `Stack`; los que tienen `Positioned` se pegan a los bordes que le digás.

## Pantallas que se adaptan

```dart
LayoutBuilder(
  builder: (context, restricciones) {
    if (restricciones.maxWidth >= 600) {
      return Row(children: [Expanded(child: menu), Expanded(child: pedido)]);
    }
    return Column(children: [menu, pedido]);
  },
)
```

`LayoutBuilder` te da las restricciones que le pasa el padre, así decidís el layout según el espacio real. 600 es un corte común entre teléfono y tableta. También existe `MediaQuery.sizeOf(context)`, que da el tamaño de toda la pantalla; `LayoutBuilder` es mejor cuando el widget no ocupa toda la pantalla.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) es el menú de una pupusería:

```
flutter run -t modulos/05_layout/ejemplo.dart
```

1. El cuerpo es un `Column` con `crossAxisAlignment.stretch`, así cada hijo ocupa todo el ancho.
2. Arriba, un `SizedBox` de 140 de alto con un `Stack`: un fondo de color y un texto pegado abajo a la izquierda con `Positioned`.
3. Después un título con `Padding`.
4. La lista va dentro de un `Expanded`, que le da todo el alto que sobra. Quitale el `Expanded` y mirá el error: es el clásico de la regla de oro.
5. Cada fila es un `Row` con el nombre en `Expanded` y el precio a la derecha.

## Errores comunes

1. Overflow en un `Row` con texto largo. Envolvé el texto en `Expanded` o `Flexible`.
2. `ListView` dentro de `Column` sin límite de alto: "Vertical viewport was given unbounded height". Envolvé la lista en `Expanded`.
3. Usar `Container` solo para dar espacio. `Padding` y `SizedBox` dicen mejor lo que querés y son más livianos.
4. Medidas fijas para todo (`width: 360`). En otro teléfono se ve mal. Dejá que `Expanded` y las restricciones hagan su trabajo.
5. `Expanded` fuera de un `Row`, `Column` o `Flex`. Tiene que ser hijo directo de uno de ellos.
6. Usar `ListView(children: ...)` con cientos de elementos. Usá `.builder`.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart):

```
flutter test test/m05_layout_test.dart
```

Estos tests no solo buscan el widget: miden dónde quedó. Por ejemplo, revisan que el precio termine a 16 píxeles del borde o que en pantalla ancha los dos paneles estén a la misma altura. Si fallan, el mensaje dice qué posición esperaba.

| # | Qué practica |
|---|---|
| 1 | `Padding`, `Row` y `Expanded` |
| 2 | `ListView.builder`, `ListTile` y el caso vacío |
| 3 | `Stack` y `Positioned` |
| 4 | `LayoutBuilder` para teléfono y pantalla ancha |
| 5 | `GridView.count` |

Solución en [`soluciones/05_layout`](../../soluciones/05_layout/ejercicios.dart).

## Repaso

1. Explicá con tus palabras la regla de oro.
2. ¿Por qué un `ListView` dentro de un `Column` necesita `Expanded`?
3. ¿Qué diferencia hay entre `Expanded` y `Flexible`?
4. ¿Por qué `ListView.builder` aguanta listas enormes?
5. En un `Stack`, ¿qué hijo queda encima?

## Para seguir leyendo

1. [Layouts en Flutter](https://docs.flutter.dev/ui/layout)
2. [Entender las restricciones](https://docs.flutter.dev/ui/layout/constraints)
3. [Diseño adaptable](https://docs.flutter.dev/ui/adaptive-responsive)
4. [Listas largas](https://docs.flutter.dev/cookbook/lists/long-lists)
