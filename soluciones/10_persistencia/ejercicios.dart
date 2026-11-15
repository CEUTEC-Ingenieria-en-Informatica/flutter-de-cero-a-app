// Módulo 10 · Persistencia local · una solución posible (hay otras).
import 'dart:convert';
import 'dart:io';

// Piezas dadas (iguales en el esqueleto).

abstract class Almacen {
  Future<String?> leer(String clave);
  Future<void> guardar(String clave, String valor);
  Future<void> borrar(String clave);
}

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
class AlmacenArchivo implements Almacen {
  AlmacenArchivo(this.carpeta);

  final Directory carpeta;

  File _archivo(String clave) => File('${carpeta.path}${Platform.pathSeparator}$clave.txt');

  @override
  Future<String?> leer(String clave) async {
    final archivo = _archivo(clave);
    if (!await archivo.exists()) return null;
    return archivo.readAsString();
  }

  @override
  Future<void> guardar(String clave, String valor) async {
    await carpeta.create(recursive: true);
    await _archivo(clave).writeAsString(valor);
  }

  @override
  Future<void> borrar(String clave) async {
    final archivo = _archivo(clave);
    if (await archivo.exists()) {
      await archivo.delete();
    }
  }
}

/// Ejercicio 2
class RepositorioNotas {
  RepositorioNotas(this.almacen);

  static const clave = 'notas';

  final Almacen almacen;

  Future<List<Nota>> cargar() async {
    final texto = await almacen.leer(clave);
    if (texto == null) return [];
    try {
      final lista = jsonDecode(texto) as List<dynamic>;
      return lista.map((e) => Nota.fromJson(e as Map<String, dynamic>)).toList();
    } on FormatException {
      return [];
    } on TypeError {
      return [];
    }
  }

  Future<void> _guardarTodas(List<Nota> notas) {
    return almacen.guardar(clave, jsonEncode(notas.map((n) => n.toJson()).toList()));
  }

  Future<void> agregar(Nota nota) async {
    final notas = await cargar();
    notas.add(nota);
    await _guardarTodas(notas);
  }

  Future<void> borrar(String id) async {
    final notas = await cargar();
    notas.removeWhere((n) => n.id == id);
    await _guardarTodas(notas);
  }
}

/// Ejercicio 3
class Preferencias {
  Preferencias(this.almacen);

  final Almacen almacen;

  Future<bool> temaOscuro() async => await almacen.leer('tema_oscuro') == 'true';

  Future<void> guardarTemaOscuro(bool valor) => almacen.guardar('tema_oscuro', '$valor');

  Future<int> vecesAbierta() async => int.tryParse(await almacen.leer('aperturas') ?? '') ?? 0;

  Future<int> registrarApertura() async {
    final nuevas = await vecesAbierta() + 1;
    await almacen.guardar('aperturas', '$nuevas');
    return nuevas;
  }
}
