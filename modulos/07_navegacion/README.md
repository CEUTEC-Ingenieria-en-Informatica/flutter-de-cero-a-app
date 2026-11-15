# 07 · Navegación

Ninguna app vive en una sola pantalla. Tocás un producto y se abre su detalle, elegís una opción y volvés con ella, entrás con tu cuenta y la pantalla de bienvenida desaparece. En Flutter todo eso lo maneja el `Navigator`, y aunque existen paquetes más elaborados (como go_router), entender el `Navigator` básico te hace entender lo que esos paquetes hacen por debajo.

## Lo que vas a aprender

1. Qué es la pila de pantallas.
2. `Navigator.push` y `Navigator.pop`.
3. Pasar datos a una pantalla y devolver datos al volver.
4. Rutas con nombre.
5. Reemplazar una pantalla con `pushReplacement`.
6. El cuidado con `context` después de un `await`.

## La pila

Pensá en las pantallas como platos apilados. `push` pone uno encima y `pop` quita el de arriba. Lo que ves siempre es el plato de arriba. La flecha de volver del `AppBar` y el botón atrás de Android hacen `pop` solos.

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => PantallaDetalle(plato: 'Baleada')),
);

Navigator.pop(context);
```

`MaterialPageRoute` envuelve tu pantalla con la animación de entrada propia de cada sistema. A la pantalla nueva le pasás los datos por el constructor, como a cualquier widget.

## Devolver un dato

`push` devuelve un `Future` que se completa cuando la otra pantalla hace `pop`. Lo que mandes en `pop` es el resultado:

```dart
// En la pantalla que pregunta
final tamano = await Navigator.push<String>(
  context,
  MaterialPageRoute(builder: (_) => const PantallaElegirTamano()),
);
if (!mounted || tamano == null) return;
setState(() => _tamano = tamano);

// En la pantalla que responde
Navigator.pop(context, 'Grande');
```

Si el usuario vuelve con la flecha sin elegir, llega `null`. Siempre consideralo.

### mounted y context.mounted

Mientras esperás con `await`, el usuario pudo cerrar la pantalla. Si después llamás `setState` o usás `context`, Flutter se queja porque ese widget ya no existe. Por eso, después de cada `await`:

1. Dentro de un `State`, revisá `mounted`.
2. En un `StatelessWidget` o en un callback, revisá `context.mounted`.

El analizador te avisa con la regla `use_build_context_synchronously`.

## Rutas con nombre

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (_) => const PantallaPortada(),
    '/acerca': (_) => const PantallaAcerca(),
  },
)

Navigator.pushNamed(context, '/acerca');
```

Sirven para pantallas a las que se llega desde muchos lados (ajustes, perfil). Si usás `routes` con `'/'`, no pongás también `home`: son dos formas de decir lo mismo y Flutter se queja.

## Reemplazar

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const PantallaPrincipal()),
);
```

Saca la pantalla actual y pone la nueva en su lugar. Es lo que querés después de iniciar sesión o de una pantalla de bienvenida: que la flecha de volver no regrese ahí. Para limpiar varias pantallas de un solo golpe existe `pushAndRemoveUntil`.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) es una lista de eventos de la comunidad:

```
flutter run -t modulos/07_navegacion/ejemplo.dart
```

1. `AppEventos` declara dos rutas con nombre: la lista y ajustes. El ícono de engranaje usa `pushNamed`.
2. Al tocar un evento, se hace `push` de `PantallaDetalleEvento` pasándole el `Evento` por el constructor.
3. El botón "Inscribirme" hace `pop(context, true)`.
4. De vuelta en la lista, el `await` recibe `true`, se revisa `context.mounted` y se muestra un `SnackBar`.

Volvé con la flecha sin inscribirte y fijate que no sale el mensaje: llegó `null`.

## Errores comunes

1. Hacer `push` dentro de `build`. Se abre una pantalla en cada reconstrucción. La navegación va en respuesta a algo: un toque, un resultado.
2. Ignorar el `null` al volver. El usuario siempre puede regresar sin elegir.
3. Usar `context` después de un `await` sin revisar `mounted`.
4. Poner `home` y además la ruta `'/'` en `routes`.
5. Usar `push` después del inicio de sesión. El usuario aprieta atrás y vuelve al formulario de entrada.
6. Escribir mal el nombre de una ruta. Un error de dedo en `'/acrca'` revienta en tiempo de ejecución. Guardá los nombres en constantes.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart). Las pantallas ya están medio armadas; te toca conectar la navegación:

```
flutter test test/m07_navegacion_test.dart
```

En estos tests vas a ver `pumpAndSettle()`: espera a que terminen las animaciones de cambio de pantalla. `pageBack()` toca la flecha de volver.

| # | Qué practica |
|---|---|
| 1 | `push` con datos por el constructor |
| 2 | Devolver un dato con `pop` y manejar el `null` |
| 3 | Rutas con nombre |
| 4 | `pushReplacement` |

Solución en [`soluciones/07_navegacion`](../../soluciones/07_navegacion/ejercicios.dart).

## Repaso

1. Dibujá la pila después de: abrir la app, tocar un evento, tocar ajustes desde ahí y volver una vez.
2. ¿Qué devuelve `await Navigator.push(...)` si el usuario vuelve con la flecha?
3. ¿Por qué hay que revisar `mounted` después de un `await`?
4. ¿Cuándo usás `pushReplacement` en vez de `push`?
5. ¿Qué ventaja tienen las rutas con nombre? ¿Y qué riesgo?

## Para seguir leyendo

1. [Navegación y rutas](https://docs.flutter.dev/ui/navigation)
2. [Navegar a una pantalla nueva y volver](https://docs.flutter.dev/cookbook/navigation/navigation-basics)
3. [Devolver datos desde una pantalla](https://docs.flutter.dev/cookbook/navigation/returning-data)
4. [Mandar datos a una pantalla nueva](https://docs.flutter.dev/cookbook/navigation/passing-data)
