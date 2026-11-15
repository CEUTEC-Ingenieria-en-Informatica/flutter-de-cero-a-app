# Flutter de cero a app

Un curso por módulos para pasar de no saber Dart a tener una app completa hecha por vos. Cada módulo trae una explicación a fondo, un ejemplo que podés correr, ejercicios con espacio para tu código y tests que te dicen si vas bien. Se aprende haciendo: escribís, corrés los tests, ves rojo, arreglás, ves verde.

Es parte de la comunidad estudiantil CEUTEC Ingeniería en Informática. No es una cuenta oficial de CEUTEC ni de UNITEC, ni material de ninguna clase.

## La ruta

| Módulo | De qué trata |
|---|---|
| [01 Dart básico](modulos/01_dart_basico/README.md) | Variables, tipos, textos, `if`, `switch` y ciclos |
| [02 Funciones y colecciones](modulos/02_funciones_y_colecciones/README.md) | Parámetros con nombre, `List`, `Map`, `Set`, `map`, `where`, `fold` |
| [03 Clases y null safety](modulos/03_clases_y_null_safety/README.md) | Constructores, `factory`, herencia, `?`, `??`, `?.` |
| [04 Widgets](modulos/04_widgets/README.md) | `StatelessWidget`, `Scaffold`, botones, `Card`, `Container` |
| [05 Layout](modulos/05_layout/README.md) | `Row`, `Column`, `Expanded`, listas, `Stack`, pantallas que se adaptan |
| [06 Estado](modulos/06_estado/README.md) | `setState`, `ValueNotifier` y `ChangeNotifier`, sin librerías |
| [07 Navegación](modulos/07_navegacion/README.md) | `push`, `pop`, devolver datos, rutas con nombre |
| [08 Formularios y validación](modulos/08_formularios/README.md) | `Form`, validadores, limpiar datos |
| [09 HTTP y JSON](modulos/09_http_y_json/README.md) | `async`, `fromJson`, `FutureBuilder`, probar sin internet |
| [10 Persistencia local](modulos/10_persistencia/README.md) | Opciones para guardar datos, archivos, datos dañados |
| [11 Tests](modulos/11_tests/README.md) | Tests unitarios y de widgets, reloj inyectado, TDD |
| [12 Proyecto final](modulos/12_proyecto_final/README.md) | App de pedidos de una pupusería inventada, en lempiras |

Hacelos en orden. Cada módulo usa lo del anterior, y el 12 usa todo.

## Lo que necesitás

1. Flutter en el canal stable. El curso se probó con Flutter 3.47.9 (Dart 3.13.7); cualquier versión stable más nueva debería funcionar.
2. Git y una cuenta de GitHub.
3. Un editor. VS Code con la extensión oficial de Flutter, o Android Studio.

Para hacer los ejercicios no necesitás emulador ni teléfono: todo se revisa con tests que corren en tu compu.

### Instalar Flutter

Seguí la [guía oficial de instalación](https://docs.flutter.dev/get-started/install) para tu sistema. Bajá Flutter solo de ahí o del repo oficial en GitHub, nunca de enlaces sueltos.

Cuando termines, abrí una terminal y corré:

```
flutter --version
flutter doctor
```

`flutter doctor` te dice qué falta. Para este curso basta con que Flutter y Dart salgan bien; lo de Android, iOS o Chrome solo hace falta para ver las apps en pantalla.

## Cómo empezar

1. Hacé tu copia: botón verde "Use this template" y "Create a new repository" (o un fork). Así tenés tu propio repo donde subir lo que resolvás.
2. Clonala y entrá a la carpeta:

   ```
   git clone https://github.com/TU_USUARIO/flutter-de-cero-a-app.git
   cd flutter-de-cero-a-app
   flutter pub get
   ```

3. Corré los tests:

   ```
   flutter test
   ```

   Va a salir casi todo en rojo. Está bien: los ejercicios están vacíos. Tu trabajo es ponerlos en verde.

## Cómo está armado

```
flutter-de-cero-a-app/
├── modulos/
│   └── 05_layout/
│       ├── README.md        la explicación: leela primero
│       ├── ejemplo.dart     el ejemplo del README, para correr y modificar
│       └── ejercicios.dart  aquí escribís vos
├── test/
│   ├── m05_layout_test.dart los tests de cada módulo
│   └── practica/            tus propios tests (módulo 11)
├── soluciones/
│   └── 05_layout/           una forma de resolverlos (hay otras)
└── herramientas/
    └── verificar_curso.sh   revisa que el curso esté sano (para quien lo mantiene)
```

Todo es un solo proyecto de Flutter, así que un solo `flutter test` revisa todos los módulos.

## Cómo estudiar con esto

1. Leé el README del módulo, sin apuro.
2. Corré el ejemplo y cambiale algo. Si no lo rompiste al menos una vez, no lo exploraste.
3. Abrí `ejercicios.dart`, resolvé uno y corré solo los tests de ese módulo:

   ```
   flutter test test/m05_layout_test.dart
   ```

4. Si te trabás más de 15 minutos, mirá la solución, cerrala y escribilo otra vez sin verla.
5. Cuando todo el módulo esté en verde, hacé commit.

Los tests no se tocan para que pasen. Si creés que un test está mal, abrí un issue y lo vemos.

## Ver los ejemplos en pantalla

Los ejemplos de los módulos 04 en adelante (menos el 10) son apps. El repo ya trae la carpeta `web/`, así que con Chrome instalado se ven sin preparar nada:

```
flutter run -d chrome -t modulos/05_layout/ejemplo.dart
```

`-t` le dice a Flutter qué archivo arrancar. Con la app abierta, cambiá algo en el código y apretá `r` en la terminal: eso es hot reload.

Si preferís un emulador de Android o la app de escritorio, agregá esa plataforma una vez con `flutter create --platforms=android .` (o `windows`, `macos`, `linux`). Ojo: ese comando también crea `lib/main.dart` y `test/widget_test.dart` con una app de ejemplo que no es del curso; borrá esos dos archivos después. Las carpetas de plataforma ya quedan fuera de git por el `.gitignore`.

Los ejemplos de los módulos 01, 02, 03 y 10 son de consola y se corren con `dart run`, como dice su README.

## Tu pull request y el check

GitHub revisa tu copia solo. El archivo `.github/workflows/revisar.yml` instala Flutter y corre `flutter analyze` y `flutter test` en cada push y en cada pull request. Para usarlo como en un equipo de verdad:

1. Creá una rama para el módulo: `git checkout -b modulo-05`
2. Resolvé, hacé commit y subí la rama: `git push -u origin modulo-05`
3. En GitHub, en tu copia, abrí un pull request de `modulo-05` hacia `main`.
4. Abajo del pull request aparece el check "revisar". Amarillo mientras corre, verde si todo pasa, rojo si algo falla.
5. Si sale rojo, tocá "Details". Ahí ves qué test falló y por qué, igual que en tu terminal.
6. Cuando esté en verde, unilo con "Merge".

Mientras vas avanzando el check va a salir rojo por los módulos que todavía no hiciste. Es normal. Lo que importa es que en el detalle ya no salgan los del módulo en que trabajaste. Cuando termines los 12, sale verde completo.

Si es la primera vez que hacés un pull request, la guía de GitHub está aquí: [Acerca de las solicitudes de incorporación de cambios](https://docs.github.com/es/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).

## Cómo contribuir al curso

Encontraste un error, un test injusto o se te ocurrió un ejercicio mejor. Dale:

1. Hacé fork y creá una rama.
2. Si tocás ejercicios, tests o soluciones, corré antes:

   ```
   bash herramientas/verificar_curso.sh
   ```

   Revisa dos cosas: que cada archivo de test falle con los esqueletos de `modulos/` (si un test pasa con el esqueleto, no está revisando nada), y que todos pasen cuando se ponen las soluciones encima, en una copia temporal. Es lo mismo que corre GitHub en el repo de la comunidad. En Windows corrélo desde Git Bash.

3. Abrí un pull request contando qué cambiaste y por qué.

Para dudas o ideas sin código, abrí un issue.

## Cómo se comprobó

Con Flutter 3.47.9 (Dart 3.13.7) se corrió `flutter analyze` sin observaciones y `bash herramientas/verificar_curso.sh`. Con los esqueletos, ninguna de las 75 pruebas de los 12 módulos pasa (cada archivo sale en rojo). Con las soluciones encima pasan todas: 76, contando la de `test/practica`. Los ejemplos con pantalla se compilaron para web con `flutter build web -t` y los de consola se corrieron con `dart run`.

## Sobre este material

Lo escribió James V con ayuda de herramientas de IA, y lo revisa la comunidad. Los ejemplos, los negocios y las personas son inventados. Las explicaciones citan la documentación oficial de [Dart](https://dart.dev) y [Flutter](https://docs.flutter.dev), que es donde tenés que ir cuando querás más detalle.

## Licencia

[MIT](LICENSE). Podés usar, copiar y adaptar el material, también para enseñar, siempre que dejés el aviso de la licencia.
