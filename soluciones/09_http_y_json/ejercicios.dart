// Módulo 09 · HTTP y JSON · una solución posible (hay otras).
import 'dart:convert';

import 'package:flutter/material.dart';

// Piezas dadas (iguales en el esqueleto).

class RespuestaHttp {
  const RespuestaHttp(this.estado, this.cuerpo);
  final int estado;
  final String cuerpo;
}

abstract class ClienteHttp {
  Future<RespuestaHttp> get(Uri url);
}

class ErrorDeServidor implements Exception {
  const ErrorDeServidor(this.estado);
  final int estado;

  @override
  String toString() => 'ErrorDeServidor($estado)';
}

/// Ejercicio 1
class Plato {
  const Plato({required this.id, required this.nombre, required this.precio, this.disponible = true});

  factory Plato.fromJson(Map<String, dynamic> json) {
    return Plato(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      precio: (json['precio'] as num).toDouble(),
      disponible: json['disponible'] as bool? ?? true,
    );
  }

  final int id;
  final String nombre;
  final double precio;
  final bool disponible;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'precio': precio,
        'disponible': disponible,
      };
}

/// Ejercicio 2
List<Plato> parsearMenu(String cuerpo) {
  final datos = jsonDecode(cuerpo) as Map<String, dynamic>;
  final platos = datos['platos'] as List<dynamic>;
  return platos.map((p) => Plato.fromJson(p as Map<String, dynamic>)).toList();
}

/// Ejercicio 3
class ServicioMenu {
  ServicioMenu(this.cliente);

  static final direccion = Uri.parse('https://api.example.com/menu');

  final ClienteHttp cliente;

  Future<List<Plato>> obtenerMenu() async {
    final respuesta = await cliente.get(direccion);
    if (respuesta.estado != 200) {
      throw ErrorDeServidor(respuesta.estado);
    }
    return parsearMenu(respuesta.cuerpo);
  }
}

/// Ejercicio 4
class PantallaMenu extends StatefulWidget {
  const PantallaMenu({super.key, required this.servicio});

  final ServicioMenu servicio;

  @override
  State<PantallaMenu> createState() => _PantallaMenuState();
}

class _PantallaMenuState extends State<PantallaMenu> {
  late Future<List<Plato>> _menu;

  @override
  void initState() {
    super.initState();
    _menu = widget.servicio.obtenerMenu();
  }

  void _reintentar() {
    // Con llaves: una flecha aquí devolvería el Future y setState se queja.
    setState(() {
      _menu = widget.servicio.obtenerMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú')),
      body: FutureBuilder<List<Plato>>(
        future: _menu,
        builder: (context, foto) {
          if (foto.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (foto.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No se pudo cargar el menú'),
                  TextButton(onPressed: _reintentar, child: const Text('Reintentar')),
                ],
              ),
            );
          }
          final platos = foto.data!;
          return ListView(
            children: [
              for (final p in platos)
                ListTile(
                  title: Text(p.nombre),
                  subtitle: p.disponible ? null : const Text('Agotado'),
                  trailing: Text('L ${p.precio.toStringAsFixed(2)}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
