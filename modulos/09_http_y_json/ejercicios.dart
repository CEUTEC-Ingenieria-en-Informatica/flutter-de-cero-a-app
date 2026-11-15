// Módulo 09 · HTTP y JSON · ejercicios
//
// Los tests no usan internet: le pasan a tu código un cliente falso que responde lo que ellos quieren.
// Para revisar solo este módulo: flutter test test/m09_http_y_json_test.dart
//
// Vas a necesitar jsonDecode: agregá aquí arriba import 'dart:convert';
import 'package:flutter/material.dart';

// Piezas dadas. No las cambiés: los tests las usan.

/// Lo que devuelve el servidor: un código de estado (200 es "todo bien") y el cuerpo como texto.
class RespuestaHttp {
  const RespuestaHttp(this.estado, this.cuerpo);
  final int estado;
  final String cuerpo;
}

/// Cualquier cosa que sepa hacer un GET. En la app real lo implementa un cliente de verdad;
/// en los tests, uno falso.
abstract class ClienteHttp {
  Future<RespuestaHttp> get(Uri url);
}

/// Se lanza cuando el servidor responde algo distinto de 200.
class ErrorDeServidor implements Exception {
  const ErrorDeServidor(this.estado);
  final int estado;

  @override
  String toString() => 'ErrorDeServidor($estado)';
}

/// Ejercicio 1
/// Convertí un plato de JSON a objeto y de vuelta.
/// 1. fromJson lee 'id' (int), 'nombre' (String), 'precio' (puede venir como 25 o 25.5: usá num y toDouble)
///    y 'disponible' (bool, opcional: si no viene, es true).
/// 2. toJson devuelve un mapa con las mismas cuatro claves.
class Plato {
  const Plato({required this.id, required this.nombre, required this.precio, this.disponible = true});

  factory Plato.fromJson(Map<String, dynamic> json) {
    // TODO
    throw UnimplementedError('TODO ejercicio 1, fromJson');
  }

  final int id;
  final String nombre;
  final double precio;
  final bool disponible;

  Map<String, dynamic> toJson() {
    // TODO
    throw UnimplementedError('TODO ejercicio 1, toJson');
  }
}

/// Ejercicio 2
/// El cuerpo es un texto así: {"platos": [{"id": 1, "nombre": "Revuelta", "precio": 25}, ...]}
/// Devolvé la lista de Plato.
List<Plato> parsearMenu(String cuerpo) {
  // TODO: jsonDecode y Plato.fromJson.
  throw UnimplementedError('TODO ejercicio 2');
}

/// Ejercicio 3
/// obtenerMenu hace GET a [direccion] con el cliente que le pasaron.
/// 1. Si el estado es 200, devolvé el menú con parsearMenu.
/// 2. Si no, lanzá ErrorDeServidor con el estado.
class ServicioMenu {
  ServicioMenu(this.cliente);

  static final direccion = Uri.parse('https://api.example.com/menu');

  final ClienteHttp cliente;

  Future<List<Plato>> obtenerMenu() async {
    // TODO
    throw UnimplementedError('TODO ejercicio 3');
  }
}

/// Ejercicio 4
/// Una pantalla (Scaffold con AppBar 'Menú') que carga el menú con FutureBuilder.
/// 1. Mientras carga: un CircularProgressIndicator centrado.
/// 2. Si falla: el texto 'No se pudo cargar el menú' y un TextButton 'Reintentar' que vuelve a pedirlo.
/// 3. Si llega: un ListTile por plato con el nombre como title y el precio 'L 25.00' como trailing.
///    Si el plato no está disponible, ponele subtitle 'Agotado'.
/// Pedí el Future en initState y guardalo en el State. NO lo pidás dentro de build.
class PantallaMenu extends StatefulWidget {
  const PantallaMenu({super.key, required this.servicio});

  final ServicioMenu servicio;

  @override
  State<PantallaMenu> createState() => _PantallaMenuState();
}

class _PantallaMenuState extends State<PantallaMenu> {
  // TODO: late Future<List<Plato>> _menu; y asignalo en initState.

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
