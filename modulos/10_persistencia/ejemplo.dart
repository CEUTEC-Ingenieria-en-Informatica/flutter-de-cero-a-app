// Ejemplo del módulo 10. Corrélo con: dart run modulos/10_persistencia/ejemplo.dart
//
// Cuenta cuántas veces lo corriste, guardando el número en un archivo dentro de la carpeta
// temporal del sistema. Corrélo varias veces y mirá cómo sube.
// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final archivo = File('${Directory.systemTemp.path}${Platform.pathSeparator}flutter_de_cero_contador.json');

  // 1. Leer lo que haya. Si no existe o está dañado, empezar de cero.
  var datos = <String, dynamic>{'veces': 0, 'ultima': null};
  if (await archivo.exists()) {
    try {
      datos = jsonDecode(await archivo.readAsString()) as Map<String, dynamic>;
    } on FormatException {
      print('El archivo estaba dañado, empiezo de cero.');
    }
  }

  // 2. Cambiar en memoria.
  final veces = (datos['veces'] as int? ?? 0) + 1;
  final ultima = datos['ultima'] as String?;
  datos = {'veces': veces, 'ultima': DateTime.now().toIso8601String()};

  // 3. Guardar todo de vuelta.
  await archivo.writeAsString(jsonEncode(datos));

  print('Lo corriste $veces ${veces == 1 ? 'vez' : 'veces'}.');
  if (ultima != null) print('La anterior fue: $ultima');
  print('Está guardado en ${archivo.path}');
}
