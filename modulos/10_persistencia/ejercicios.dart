// Módulo 10 · Persistencia local · ejercicios
//
// Sin plugins nativos: todo se apoya en la interfaz Almacen. Los tests usan la versión en memoria
// y una carpeta temporal de verdad, así corren en cualquier compu y en GitHub.
// Para revisar solo este módulo: flutter test test/m10_persistencia_test.dart
//
// Para el ejercicio 2 vas a necesitar jsonDecode y jsonEncode: agregá import 'dart:convert';
import 'dart:io';

// Piezas dadas. No las cambiés: los tests las usan.

/// Guardar y leer textos por clave. Es la misma idea que shared_preferences, sin el plugin.
abstract class Almacen {
  Future<String?> leer(String clave);
  Future<void> guardar(String clave, String valor);
  Future<void> borrar(String clave);
}

/// Un almacén que vive en memoria y se pierde al cerrar la app. Perfecto para tests.
class AlmacenEnMemoria implements Almacen {
  final _datos = <String, String>{};

  @override
  Future<String?> leer(String clave) async => _datos[clave];

  @override
  Future<void> guardar(String clave, String valor) async => _datos[clave] = valor;

  @override
  Future<void> borrar(String clave) async => _datos.remove(clave);
}

class Nota {
  const Nota({required this.id, required this.texto});

  factory Nota.fromJson(Map<String, dynamic> json) =>
      Nota(id: json['id'] as String, texto: json['texto'] as String);

  final String id;
  final String texto;

  Map<String, dynamic> toJson() => {'id': id, 'texto': texto};
}

/// Ejercicio 1
/// Un Almacen que guarda cada clave en un archivo de texto dentro de [carpeta]: la clave 'notas'
/// va al archivo notas.txt.
/// 1. leer devuelve null si el archivo no existe.
/// 2. guardar crea la carpeta si hace falta (create(recursive: true)) y escribe el texto.
/// 3. borrar elimina el archivo si existe. Si no existe, no hace nada ni falla.
class AlmacenArchivo implements Almacen {
  AlmacenArchivo(this.carpeta);

  final Directory carpeta;

  // Pista: File('${carpeta.path}${Platform.pathSeparator}$clave.txt')

  @override
  Future<String?> leer(String clave) async {
    // TODO
    throw UnimplementedError('TODO ejercicio 1, leer');
  }

  @override
  Future<void> guardar(String clave, String valor) async {
    // TODO
    throw UnimplementedError('TODO ejercicio 1, guardar');
  }

  @override
  Future<void> borrar(String clave) async {
    // TODO
    throw UnimplementedError('TODO ejercicio 1, borrar');
  }
}

/// Ejercicio 2
/// Las notas se guardan todas juntas como una lista JSON bajo la clave 'notas'.
/// 1. cargar devuelve la lista. Si no hay nada guardado, o lo guardado está dañado
///    (no es JSON o no tiene la forma esperada), devuelve una lista vacía en vez de reventar.
/// 2. agregar suma una nota al final y guarda.
/// 3. borrar quita la nota con ese id y guarda.
class RepositorioNotas {
  RepositorioNotas(this.almacen);

  static const clave = 'notas';

  final Almacen almacen;

  Future<List<Nota>> cargar() async {
    // TODO: try con on FormatException y on TypeError.
    throw UnimplementedError('TODO ejercicio 2, cargar');
  }

  Future<void> agregar(Nota nota) async {
    // TODO
    throw UnimplementedError('TODO ejercicio 2, agregar');
  }

  Future<void> borrar(String id) async {
    // TODO
    throw UnimplementedError('TODO ejercicio 2, borrar');
  }
}

/// Ejercicio 3
/// Preferencias del usuario sobre cualquier Almacen.
/// 1. temaOscuro devuelve false si nunca se guardó. guardarTemaOscuro lo guarda.
/// 2. vecesAbierta devuelve 0 si nunca se guardó (o si lo guardado no es número).
/// 3. registrarApertura suma 1, lo guarda y devuelve el nuevo total.
/// Usá las claves 'tema_oscuro' y 'aperturas'. Todo se guarda como texto.
class Preferencias {
  Preferencias(this.almacen);

  final Almacen almacen;

  Future<bool> temaOscuro() async {
    // TODO
    throw UnimplementedError('TODO ejercicio 3, temaOscuro');
  }

  Future<void> guardarTemaOscuro(bool valor) async {
    // TODO
    throw UnimplementedError('TODO ejercicio 3, guardarTemaOscuro');
  }

  Future<int> vecesAbierta() async {
    // TODO
    throw UnimplementedError('TODO ejercicio 3, vecesAbierta');
  }

  Future<int> registrarApertura() async {
    // TODO
    throw UnimplementedError('TODO ejercicio 3, registrarApertura');
  }
}
