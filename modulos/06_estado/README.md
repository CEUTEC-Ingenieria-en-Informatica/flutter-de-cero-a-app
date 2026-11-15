# 06 · Estado

Hasta ahora tus pantallas eran fotos: se dibujaban una vez y ya. Una app de verdad cambia: sumás un producto al carrito, marcás una tarea, activás el modo oscuro. A los datos que cambian y que la pantalla tiene que reflejar se les llama estado. Hay decenas de librerías para manejarlo (Provider, Riverpod, Bloc), pero todas se apoyan en tres piezas que ya trae Flutter. Si entendés estas tres, cualquier librería te va a parecer conocida.

## Lo que vas a aprender

1. `StatefulWidget` y `setState` para estado local.
2. `ValueNotifier` con `ValueListenableBuilder` para un valor que escuchan varios.
3. `ChangeNotifier` con `ListenableBuilder` para un modelo con lógica.
4. Dónde poner el estado: local o compartido.
5. Liberar lo que creás con `dispose`.

## setState: estado que vive dentro de un widget

```dart
class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int _valor = 0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => setState(() => _valor++),
      child: Text('$_valor'),
    );
  }
}
```

Son dos clases: el widget (que es inmutable, como siempre) y su `State`, que vive mientras el widget esté en pantalla y guarda los datos que cambian. `setState` hace dos cosas: ejecuta tu cambio y le avisa a Flutter que vuelva a llamar a `build`. Si cambiás `_valor` sin `setState`, el dato cambia pero la pantalla no se entera.

Dentro del `State`, los parámetros del widget se leen con `widget.nombre`.

## Levantar el estado

Si dos widgets necesitan el mismo dato (la lista del carrito y el contador del ícono del carrito), el estado no puede vivir en ninguno de los dos. Se sube al ancestro común o se saca a un objeto aparte que los dos escuchan. Eso es lo que resuelven las dos piezas siguientes.

## ValueNotifier: un solo valor observable

```dart
final oscuro = ValueNotifier(false);

ValueListenableBuilder<bool>(
  valueListenable: oscuro,
  builder: (context, valor, _) => Switch(
    value: valor,
    onChanged: (nuevo) => oscuro.value = nuevo,
  ),
)
```

Cada vez que asignás `oscuro.value`, se reconstruye solo lo que está dentro del `builder`. Cualquier parte de la app que tenga el mismo `ValueNotifier` se entera. Sirve para valores sueltos: un tema, un filtro, una pestaña elegida.

## ChangeNotifier: un modelo con reglas

```dart
class ModeloCarrito extends ChangeNotifier {
  final List<(String, double)> _articulos = [];

  int get cantidad => _articulos.length;
  double get total => _articulos.fold(0.0, (s, a) => s + a.$2);

  void agregar(String nombre, double precio) {
    _articulos.add((nombre, precio));
    notifyListeners();
  }
}

ListenableBuilder(
  listenable: carrito,
  builder: (context, _) => Text('Total: L ${carrito.total.toStringAsFixed(2)}'),
)
```

El modelo guarda los datos privados, expone getters de solo lectura y métodos con las reglas del negocio. Después de cada cambio llama a `notifyListeners()`. La interfaz no sabe cómo se calcula el total; solo lo muestra. Así podés probar el modelo con tests rápidos, sin dibujar nada (lo hacés en el ejercicio 2).

`(String, double)` es un record: una forma corta de juntar dos valores sin crear una clase. Se leen con `.$1` y `.$2`.

## ¿Cuál uso?

| Situación | Herramienta |
|---|---|
| Algo que solo le importa a un widget: un campo de texto, una animación, si un panel está abierto | `setState` |
| Un valor suelto que escuchan varios | `ValueNotifier` |
| Datos con reglas: carrito, sesión, lista de tareas | `ChangeNotifier` |

Cuando la app crezca y tengas que pasar el modelo por muchos niveles, ahí entran librerías como Provider. Por dentro hacen lo mismo que viste aquí.

## dispose

Los `ValueNotifier`, `ChangeNotifier` y `TextEditingController` que creás dentro de un `State` se liberan en `dispose`:

```dart
@override
void dispose() {
  _controlador.dispose();
  super.dispose();
}
```

Si no, quedan escuchando aunque la pantalla ya no exista.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) es una lista de tareas con modo oscuro:

```
flutter run -t modulos/06_estado/ejemplo.dart
```

1. `ListaTareas` es un `ChangeNotifier` con la lista privada y dos métodos que avisan.
2. `AppTareas` crea el modelo y un `ValueNotifier` para el tema, y los libera en `dispose`.
3. El `ValueListenableBuilder` de arriba reconstruye el `MaterialApp` cuando cambia el tema.
4. El `ListenableBuilder` reconstruye solo la lista cuando cambian las tareas.
5. `CampoNuevaTarea` tiene estado local con `setState`: si hay texto, el botón se activa. Ese dato no le importa a nadie más, por eso no está en el modelo.

## Errores comunes

1. Cambiar el dato sin `setState`. La pantalla queda vieja hasta que algo más la redibuje.
2. Llamar a `setState` dentro de `build`. Crea un ciclo infinito.
3. Olvidar `notifyListeners()` en un método del modelo. Los datos cambian y nadie se entera.
4. Exponer la lista privada directamente (`List<String> get tareas => _tareas`). Cualquiera puede hacer `tareas.add(...)` sin pasar por tus reglas ni avisar. Devolvé `List.unmodifiable(...)`.
5. Crear el `ChangeNotifier` dentro de `build`. Se crea uno nuevo en cada reconstrucción y se pierde todo. Crealo en el `State` o más arriba.
6. No llamar `dispose`.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart):

```
flutter test test/m06_estado_test.dart
```

En los tests de widgets vas a ver `await tester.pump()` después de cada toque: le dice al entorno de pruebas que dibuje el siguiente cuadro, como pasaría en el teléfono.

| # | Qué practica |
|---|---|
| 1 | `StatefulWidget`, `setState` y un botón que se desactiva |
| 2 | `ChangeNotifier` con reglas y avisos justos |
| 3 | `ValueNotifier` en las dos direcciones |
| 4 | `ListenableBuilder` conectado al modelo |

Solución en [`soluciones/06_estado`](../../soluciones/06_estado/ejercicios.dart).

## Repaso

1. ¿Qué dos cosas hace `setState`?
2. ¿Por qué un `StatefulWidget` necesita dos clases?
3. Tenés un ícono de carrito en la barra de arriba que muestra cuántos artículos hay, y la pantalla del menú que agrega. ¿Dónde vive el estado?
4. ¿Qué pasa si devolvés la lista privada tal cual desde un getter?
5. ¿Cuándo preferís `ValueNotifier` sobre `ChangeNotifier`?

## Para seguir leyendo

1. [Interactividad y StatefulWidget](https://docs.flutter.dev/ui/interactivity)
2. [Manejo de estado, introducción](https://docs.flutter.dev/data-and-backend/state-mgmt/intro)
3. [Estado simple de la app](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)
4. [Records en Dart](https://dart.dev/language/records)
