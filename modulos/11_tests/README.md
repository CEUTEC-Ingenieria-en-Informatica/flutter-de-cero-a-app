# 11 · Tests

Llevás diez módulos usando tests sin escribir ninguno: eran los que te decían "bien" o "falta". Ahora te toca del otro lado. Un test es un programa pequeño que revisa que tu programa haga lo que dice. Sirven para tres cosas: saber que algo funciona sin probarlo a mano cada vez, cambiar código sin miedo a romper lo que ya andaba, y dejar escrito qué se espera, como una especificación que se revisa sola.

## Lo que vas a aprender

1. Los tres tipos de test en Flutter.
2. La forma de un test: preparar, actuar, revisar.
3. `test`, `group`, `expect` y los matchers más usados.
4. Tests de widgets: `pumpWidget`, `find`, `tap`, `enterText`, `pump`.
5. Escribir código que se pueda probar: inyectar el reloj, el cliente HTTP y el almacén.
6. Controlar el tiempo en un test.
7. Trabajar con TDD: el test primero.

## Tres tipos de test

| Tipo | Qué prueba | Velocidad | En este curso |
|---|---|---|---|
| Unitario | Una función o clase, sin pantalla | Milisegundos | Módulos 01, 02, 03 y casi todo el 08, 09 y 10 |
| De widget | Un widget dibujado en una pantalla invisible | Rápido | Módulos 04 al 09 |
| De integración | La app completa en un teléfono o emulador | Lento | Se menciona al final |

La regla práctica: muchos unitarios, bastantes de widget y pocos de integración. Mientras más lógica sacás de los widgets (como el `ModeloCarrito` del módulo 06), más podés probar con tests unitarios rápidos.

## La forma de un test

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calcularPropina', () {
    test('saca el 10 % por defecto', () {
      // preparar
      const cuenta = 250.0;
      // actuar
      final propina = calcularPropina(cuenta);
      // revisar
      expect(propina, 25.0);
    });
  });
}
```

`group` junta tests relacionados. El nombre de cada `test` debe decir qué comportamiento revisa, porque es lo primero que leés cuando falla.

### Matchers que vas a usar

| Matcher | Ejemplo |
|---|---|
| igualdad | `expect(total, 70)` |
| `isTrue`, `isFalse`, `isNull`, `isNotNull` | `expect(cuenta.retirar(0), isFalse)` |
| `hasLength`, `isEmpty`, `contains` | `expect(lista, hasLength(3))` |
| `closeTo` | `expect(area, closeTo(3.1416, 0.0001))` para decimales |
| `throwsArgumentError`, `throwsA(...)` | `expect(() => Producto('', 1), throwsArgumentError)` |
| `findsOneWidget`, `findsNothing`, `findsNWidgets` | en tests de widgets |

Para revisar que algo lanza un error, se pasa una función `() => ...`, no la llamada directa.

## Tests de widgets

```dart
testWidgets('muestra la propina al escribir', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: Scaffold(body: CalculadoraPropina())));

  await tester.enterText(find.byKey(const Key('cuenta')), '300');
  await tester.pump();

  expect(find.text('Propina: L 30.00'), findsOneWidget);
});
```

1. `pumpWidget` dibuja el widget. Casi siempre va envuelto en `MaterialApp`.
2. `find` busca: `find.text`, `find.byType`, `find.byIcon`, `find.byKey`, `find.widgetWithText`.
3. `tap` y `enterText` actúan como una persona.
4. `pump()` dibuja el siguiente cuadro. Después de cualquier cambio de estado hay que llamarlo.
5. `pumpAndSettle()` dibuja cuadros hasta que no quede ninguna animación, útil al navegar.

Las `Key` son la forma más estable de encontrar un widget: no se rompen si cambiás el texto o el diseño.

## Código que se deja probar

Lo más difícil de probar es lo que depende de afuera: la hora, la red, el disco. La solución es siempre la misma, y ya la usaste: recibir eso desde afuera.

```dart
class SaludoDelDia {
  SaludoDelDia({DateTime Function()? ahora}) : _ahora = ahora ?? DateTime.now;
  final DateTime Function() _ahora;
}

// En el test: un reloj que siempre dice las 7 de la mañana.
SaludoDelDia(ahora: () => DateTime(2026, 1, 1, 7)).saludo();
```

En la app no mandás nada y usa la hora real. En el test controlás la hora y podés revisar mediodía, medianoche o un domingo sin esperar a que llegue. Es lo mismo que hiciste con `ClienteHttp` (módulo 09) y `Almacen` (módulo 10).

## Controlar el tiempo

Dentro de `testWidgets` el tiempo es falso: los `Timer` y `Future.delayed` no esperan de verdad, avanzan cuando vos decís con `pump(Duration)`.

```dart
await tester.enterText(campo, 'pupusa');
await tester.pump(const Duration(milliseconds: 299));
expect(busquedas, isEmpty);
await tester.pump(const Duration(milliseconds: 1));
expect(busquedas, ['pupusa']);
```

Así un test de "esperá 300 ms" corre al instante. Si dejás un `Timer` pendiente al final de un test de widget, el test falla con "A Timer is still pending": casi siempre es un `dispose` que no cancela.

## TDD: el test primero

Test Driven Development es escribir el test antes que el código:

1. Rojo: escribí un test de lo que querés. Corre y falla, porque el código no existe.
2. Verde: escribí lo mínimo para que pase.
3. Mejorar: ordená el código con el test como red de seguridad.

Es exactamente como venías trabajando en este curso, solo que ahora vos escribís el rojo. Con los errores pasa igual: antes de arreglar un bug, escribí un test que lo muestre. Si no podés escribir ese test, todavía no entendés el bug.

## Integración y cobertura, en corto

1. Los tests de integración usan el paquete `integration_test` del SDK y corren la app de verdad en un emulador. Son lentos; se usan para los recorridos más importantes, como "hacer un pedido de principio a fin".
2. `flutter test --coverage` genera un reporte de qué líneas tocaron los tests. Sirve para encontrar huecos, no como meta: 100 % de cobertura con malas revisiones no vale nada.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) tiene una función pura (`calcularPropina`) y un widget pequeño que la usa. Los dos tests de este README (el de `group` y el de `testWidgets`) son justo los que le corresponden. Copialos a `test/practica/mis_tests_test.dart` (cambiá el import a `../../modulos/11_tests/ejemplo.dart`) y corrélos.

Fijate en las decisiones que lo hacen fácil de probar:

1. El cálculo está fuera del widget. Se prueba sin dibujar nada.
2. El campo y el resultado tienen `Key`.
3. Un número negativo lanza `ArgumentError`, que se puede revisar con `throwsArgumentError`.

## Errores comunes

1. Probar la implementación en vez del comportamiento. Si tu test se rompe cada vez que renombrás una variable privada, está mirando lo que no debe.
2. Olvidar `await` en `tap`, `enterText` o `pump`. El test revisa antes de que pase algo.
3. Olvidar `pump()` después de un cambio. El estado cambió, pero la pantalla todavía no.
4. Tests que dependen de la hora real o de internet. Pasan hoy y fallan mañana. Inyectá el reloj y el cliente.
5. Un test gigante que revisa diez cosas. Cuando falla, no sabés cuál. Mejor varios tests con nombres claros.
6. Ver el test en verde sin haberlo visto en rojo. Si nunca falló, no sabés si de verdad revisa algo. Por eso este curso exige que todos los tests fallen con el esqueleto.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart). Este módulo se trabaja al revés: abrí primero `test/m11_tests_test.dart` y leelo, porque es la especificación.

```
flutter test test/m11_tests_test.dart
```

| # | Qué practica |
|---|---|
| 1 | Reglas con fechas y bordes exactos (abierto a las 20:59, cerrado a las 21:00) |
| 2 | Inyectar el reloj |
| 3 | Encontrar errores en código que ya existe, escribiendo tu test primero en [`test/practica/mis_tests_test.dart`](../../test/practica/mis_tests_test.dart) |
| 4 | Tiempo falso con `pump(Duration)` y limpiar en `dispose` |

En el 3 la función ya está escrita, pero tiene dos errores. No mirés el test del curso todavía: escribí vos los casos que se te ocurran, buscá los dos errores y después compará.

Solución en [`soluciones/11_tests`](../../soluciones/11_tests/ejercicios.dart).

## Repaso

1. ¿Qué diferencia hay entre un test unitario y uno de widget? ¿Cuándo usás cada uno?
2. ¿Por qué `expect(() => f(), throwsArgumentError)` lleva `() =>`?
3. ¿Qué hace `pump()` y qué hace `pumpAndSettle()`?
4. ¿Cómo probarías una función que dice "Feliz Navidad" solo el 24 de diciembre?
5. ¿Por qué hay que ver un test en rojo antes de creerle el verde?

## Para seguir leyendo

1. [Introducción a los tests en Flutter](https://docs.flutter.dev/testing/overview)
2. [Tests unitarios](https://docs.flutter.dev/cookbook/testing/unit/introduction)
3. [Tests de widgets](https://docs.flutter.dev/cookbook/testing/widget/introduction)
4. [Tests de integración](https://docs.flutter.dev/testing/integration-tests)
