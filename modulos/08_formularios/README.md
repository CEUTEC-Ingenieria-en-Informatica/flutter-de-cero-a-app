# 08 · Formularios y validación

Registrarte, hacer un pedido, dejar una reseña: casi toda app pide datos. Y la gente escribe de todo: espacios de más, teléfonos con guion, correos sin arroba, "dos" donde iba un número. Un buen formulario avisa del error justo donde está, con un mensaje que se entiende, y nunca deja pasar basura a tu lógica.

## Lo que vas a aprender

1. `TextField` y `TextEditingController`.
2. `Form`, `TextFormField` y `GlobalKey<FormState>`.
3. Escribir validadores como funciones puras que se pueden probar solas.
4. Limpiar los datos antes de usarlos.
5. Teclado adecuado, `autovalidateMode` y otros detalles de experiencia.

## Leer lo que escriben

```dart
final _nombre = TextEditingController();

TextField(
  controller: _nombre,
  decoration: const InputDecoration(labelText: 'Nombre'),
)

print(_nombre.text); // lo que hay escrito ahora
```

El controlador guarda el texto y te deja leerlo, cambiarlo o borrarlo (`clear()`). Se crea en el `State` y se libera en `dispose`, igual que viste en el módulo 06.

## Form y TextFormField

Para validar varios campos juntos se usa `Form`:

```dart
final _formulario = GlobalKey<FormState>();

Form(
  key: _formulario,
  child: Column(children: [
    TextFormField(
      controller: _telefono,
      keyboardType: TextInputType.phone,
      validator: validarTelefonoHn,
    ),
    FilledButton(
      onPressed: () {
        if (_formulario.currentState!.validate()) {
          // todo bien: usá los datos
        }
      },
      child: const Text('Enviar'),
    ),
  ]),
)
```

`validate()` corre el `validator` de cada campo. Si alguno devuelve un texto, ese texto aparece en rojo debajo del campo y `validate()` devuelve `false`. Si todos devuelven `null`, devuelve `true`.

## Validadores: funciones puras

Un validador es solo una función `String? Function(String?)`:

```dart
String? validarCantidad(String? valor) {
  final numero = int.tryParse(valor?.trim() ?? '');
  if (numero == null) return 'Escribí un número';
  if (numero < 1 || numero > 50) return 'Entre 1 y 50';
  return null;
}
```

Escribilos fuera del widget. Así los probás con tests rápidos, sin pantalla, y los reutilizás en cualquier formulario. Un validador hace una sola cosa y su mensaje dice qué hacer para arreglarlo ("Escribí un número"), no solo "Error".

### Expresiones regulares, sin miedo

```dart
RegExp(r'^[23789]\d{7}$').hasMatch('98765432'); // true
```

Se lee: inicio (`^`), un dígito que sea 2, 3, 7, 8 o 9, después exactamente 7 dígitos (`\d{7}`) y fin (`$`). La `r` antes de las comillas hace que `\d` no se tome como escape de Dart. Para correos, una expresión simple basta: ninguna expresión regular valida todos los correos reales, y la única forma segura de saber si un correo existe es mandarle un mensaje.

## Limpiar antes de usar

Validar no es lo mismo que limpiar. Si el usuario escribe `'  Rosa '` o `'9876-5432'`, guardá `'Rosa'` y `'98765432'`. Hacé la limpieza en un solo lugar (como `normalizarTelefono`) y usala tanto al validar como al guardar, así nunca se contradicen.

## Detalles que se notan

1. `keyboardType: TextInputType.phone` o `.number` saca el teclado correcto en el teléfono.
2. `textInputAction: TextInputAction.next` pone "siguiente" en el teclado.
3. `autovalidateMode: AutovalidateMode.onUserInteraction` revisa mientras escribís, pero solo después de tocar el campo. Es menos agresivo que marcar todo en rojo desde que abre la pantalla.
4. `obscureText: true` para contraseñas.

## Ejemplo explicado

[`ejemplo.dart`](ejemplo.dart) es la inscripción a un taller:

```
flutter run -t modulos/08_formularios/ejemplo.dart
```

1. El `State` tiene la llave del `Form`, dos controladores y un `bool` para la casilla. Todo se libera en `dispose`.
2. Cada `TextFormField` trae su validador. El del correo da dos mensajes distintos según el problema.
3. `_inscribir` primero valida el `Form`. La casilla no es parte del `Form`, así que se revisa aparte y se avisa con un `SnackBar`.
4. Si todo está bien, muestra un mensaje con los datos limpios (`trim()`), resetea el formulario y vacía los controladores.

## Errores comunes

1. Validar dentro del botón con `if` sueltos. Funciona, pero los errores no aparecen junto al campo y no podés probar la lógica sola.
2. Olvidar `trim()`. `'   '` pasa como "no vacío".
3. `int.parse` en vez de `int.tryParse` con datos del usuario. `parse` lanza una excepción si el texto no es número.
4. Mensajes vagos: "Dato inválido". Decí qué se espera.
5. Validar en la app y confiar en eso. Si los datos van a un servidor, el servidor también valida: la app se puede saltar.
6. No liberar los controladores.

## Ejercicios

En [`ejercicios.dart`](ejercicios.dart):

```
flutter test test/m08_formularios_test.dart
```

Los ejercicios 1 al 4 son funciones puras y se prueban sin pantalla. El 5 usa `tester.enterText` para escribir en los campos, como si fuera una persona.

| # | Qué practica |
|---|---|
| 1 | Validador de campo obligatorio |
| 2 | Expresión regular simple para correo |
| 3 | Limpiar y validar un teléfono de Honduras |
| 4 | `int.tryParse` y rangos |
| 5 | `Form` completo que solo envía datos válidos y limpios |

Solución en [`soluciones/08_formularios`](../../soluciones/08_formularios/ejercicios.dart).

## Repaso

1. ¿Qué devuelve un validador cuando el dato está bien?
2. ¿Por qué conviene escribir los validadores fuera del widget?
3. ¿Qué diferencia hay entre `int.parse` e `int.tryParse`?
4. Explicá con palabras la expresión `^[23789]\d{7}$`.
5. ¿Por qué validar en la app no alcanza si los datos van a un servidor?

## Para seguir leyendo

1. [Crear un formulario con validación](https://docs.flutter.dev/cookbook/forms/validation)
2. [Leer el valor de un campo de texto](https://docs.flutter.dev/cookbook/forms/retrieve-input)
3. [Expresiones regulares en Dart](https://api.dart.dev/stable/dart-core/RegExp-class.html)
