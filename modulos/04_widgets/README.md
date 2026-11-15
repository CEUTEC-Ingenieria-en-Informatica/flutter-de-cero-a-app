# 04 · Widgets

Aquí empieza Flutter de verdad. En Flutter no hay archivos de diseño aparte: la pantalla se describe con código, armando un árbol de widgets. Un texto es un widget, un margen es un widget, la pantalla entera es un widget. Cuando lo entendés, el resto del framework se vuelve predecible.

## Lo que vas a aprender

1. Qué es un widget y cómo se arma el árbol.
2. `StatelessWidget` y su método `build`.
3. Los widgets que vas a usar en todas las pantallas: `MaterialApp`, `Scaffold`, `AppBar`, `Text`, `Icon`, botones, `Card` y `Container`.
4. Pasar datos y funciones a un widget por el constructor.
5. Por qué se escribe `const` en tantos lados.

## La idea: la interfaz es una función de tus datos

Un widget no es la cosa que ves en pantalla; es la descripción de cómo debe verse. Flutter lee esa descripción y dibuja. Si los datos cambian, se vuelve a pedir la descripción y Flutter actualiza solo lo que cambió.

```dart
class TarjetaSaludo extends StatelessWidget {
  const TarjetaSaludo({super.key, required this.nombre});

  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.waving_hand),
            const SizedBox(width: 8),
            Text('Hola, $nombre'),
          ],
        ),
      ),
    );
  }
}
```

Fijate en tres cosas:

1. Recibe sus datos por el constructor y los guarda en campos `final`. Un `StatelessWidget` no cambia por dentro: si algo cambia, Flutter crea otro.
2. `build` devuelve otro widget. Ese widget tiene hijos (`child` para uno, `children` para varios), y así se forma el árbol.
3. `super.key` pasa la llave al padre. No la vas a usar mucho al principio, pero los tests sí la usan para encontrar widgets.

## Los de todos los días

| Widget | Para qué |
|---|---|
| `MaterialApp` | La raíz de la app: tema, título, navegación. Va una sola vez |
| `Scaffold` | El esqueleto de una pantalla: `appBar`, `body`, `floatingActionButton` |
| `AppBar` | La barra de arriba con el título |
| `Text` | Texto, con `style` para tamaño, color y peso |
| `Icon` | Un ícono de `Icons` |
| `ElevatedButton`, `TextButton`, `FilledButton` | Botones; reciben `onPressed` y un `child` |
| `FloatingActionButton` | El botón redondo flotante |
| `Card` | Superficie con bordes redondeados y sombra suave |
| `Container` | Caja con tamaño, márgenes, color y `decoration` |
| `Padding`, `SizedBox`, `Center` | Espacio y posición. Se ven a fondo en el módulo 05 |

## Pasar funciones a un widget

Un botón no sabe qué hacer cuando lo tocan; se lo decís vos con una función:

```dart
class BotonAccion extends StatelessWidget {
  const BotonAccion({super.key, required this.texto, required this.alPresionar});

  final String texto;
  final VoidCallback alPresionar; // una función sin parámetros que no devuelve nada

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: alPresionar, child: Text(texto));
  }
}
```

Así el widget queda reutilizable: la pantalla que lo usa decide qué pasa. Si mandás `onPressed: null`, el botón se ve desactivado.

## Por qué tanto const

`const Text('Hola')` le dice a Dart que ese widget nunca cambia, así que se crea una vez y se reutiliza en cada `build`. El analizador te sugiere `const` donde se puede (regla `prefer_const_constructors`). No es obligatorio para que funcione, pero hace la app más liviana. Un widget que usa una variable, como `Text('Hola, $nombre')`, no puede ser `const`.

## Decorar con Container

```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Text('Nuevo', style: TextStyle(color: Colors.white)),
)
```

Si usás `decoration`, el color va dentro de `BoxDecoration` y no en `color` del `Container`. Si ponés los dos, Flutter lanza un error.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) es una app completa con una tarjeta de presentación:

```
flutter run -t modulos/04_widgets/ejemplo.dart
```

(La primera vez leé "Ver los ejemplos en pantalla" en el [README principal](../../README.md).)

1. `main` llama a `runApp` con el widget raíz, `MiApp`.
2. `MiApp` arma el `MaterialApp` con un tema a partir de un color semilla y pone `PantallaTarjeta` como pantalla inicial.
3. `PantallaTarjeta` usa `Scaffold` con `AppBar` y centra una `TarjetaPersona`.
4. `TarjetaPersona` es un widget propio que recibe nombre, carrera y ciudad. Adentro usa `Theme.of(context)` para tomar los estilos de texto del tema en vez de inventar tamaños.

Cambiá el color semilla, agregá un campo de correo a la tarjeta y mirá cómo se actualiza con hot reload (tecla `r` en la terminal).

## Errores comunes

1. Poner `color` en el `Container` y además `decoration`. Revienta con un mensaje claro; leelo.
2. Escribir lógica pesada dentro de `build`. `build` puede correr muchas veces por segundo; ahí solo se describe la interfaz.
3. Olvidar `MaterialApp` arriba de todo. Sin él, widgets como `Scaffold` o `Text` no encuentran tema ni dirección del texto.
4. Hacer un widget gigante de 300 líneas. Si una parte tiene nombre propio (una tarjeta, una fila), sacala a su propio widget.
5. Llamar a la función en vez de pasarla: `onPressed: alPresionar()` la ejecuta al construir. Lo correcto es `onPressed: alPresionar` o `onPressed: () => alPresionar()`.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart). Cada `build` devuelve un `Placeholder` que tenés que cambiar:

```
flutter test test/m04_widgets_test.dart
```

Los tests de widgets dibujan tu widget en una pantalla invisible y lo buscan con `find.text`, `find.byIcon` o `find.byType`. Si un test falla, el mensaje te dice qué no encontró. Lo ves a fondo en el módulo 11.

| # | Qué practica |
|---|---|
| 1 | `Card`, `Padding`, `Row`, `Icon` y `Text` |
| 2 | Decidir qué mostrar con un `if` en `build` y dar estilo a un texto |
| 3 | Recibir una función y conectarla a un botón |
| 4 | `Scaffold` completo con `AppBar`, cuerpo y botón flotante |
| 5 | `Container` con `BoxDecoration` |

Solución en [`soluciones/04_widgets`](../../soluciones/04_widgets/ejercicios.dart).

## Repaso

1. ¿Por qué los campos de un `StatelessWidget` son `final`?
2. ¿Qué diferencia hay entre `child` y `children`?
3. ¿Qué pasa si escribís `onPressed: guardar()` en vez de `onPressed: guardar`?
4. ¿Por qué `Text('Hola, $nombre')` no puede ser `const`?
5. Dibujá en papel el árbol de widgets de la tarjeta del ejemplo.

## Para seguir leyendo

1. [Introducción a los widgets](https://docs.flutter.dev/ui)
2. [Catálogo de widgets](https://docs.flutter.dev/ui/widgets)
3. [Widgets básicos de Material](https://docs.flutter.dev/ui/widgets/material)
4. [Hot reload](https://docs.flutter.dev/tools/hot-reload)
