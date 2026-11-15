// Módulo 08 · Formularios y validación · ejercicios
//
// Un validador recibe el texto del campo y devuelve null si está bien,
// o el mensaje de error si está mal.
// Para revisar solo este módulo: flutter test test/m08_formularios_test.dart
import 'package:flutter/material.dart';

/// Ejercicio 1
/// Si el valor es null, vacío o solo espacios, devolvé el nombre del campo más ' es obligatorio'.
/// validarRequerido('', campo: 'El nombre') devuelve 'El nombre es obligatorio'.
String? validarRequerido(String? valor, {String campo = 'Este campo'}) {
  // TODO
  throw UnimplementedError('TODO ejercicio 1');
}

/// Ejercicio 2
/// 1. Vacío: 'El correo es obligatorio' (reutilizá validarRequerido).
/// 2. Tiene que tener algo, una arroba, algo, un punto y algo, sin espacios: si no, 'Correo no válido'.
/// No hace falta la expresión perfecta; ninguna lo es. Una simple y clara basta.
String? validarCorreo(String? valor) {
  // TODO: RegExp y hasMatch.
  throw UnimplementedError('TODO ejercicio 2');
}

/// Ejercicio 3
/// Teléfono de Honduras.
/// 1. normalizarTelefono quita espacios y guiones: '9876 5432' y '9876-5432' quedan '98765432'.
/// 2. validarTelefonoHn: vacío da 'El teléfono es obligatorio'.
///    Ya normalizado, debe tener 8 dígitos y empezar con 2, 3, 7, 8 o 9.
///    Si no, 'Teléfono no válido (8 dígitos)'.
String normalizarTelefono(String valor) {
  // TODO
  throw UnimplementedError('TODO ejercicio 3, normalizarTelefono');
}

String? validarTelefonoHn(String? valor) {
  // TODO
  throw UnimplementedError('TODO ejercicio 3, validarTelefonoHn');
}

/// Ejercicio 4
/// Si no es un número entero: 'Escribí un número'. Si no está entre 1 y 50: 'Entre 1 y 50'.
String? validarCantidad(String? valor) {
  // TODO: int.tryParse devuelve null si no puede convertir.
  throw UnimplementedError('TODO ejercicio 4');
}

/// Lo que devuelve el formulario cuando todo está bien. Ya está lista.
class DatosPedido {
  const DatosPedido({required this.nombre, required this.telefono, required this.cantidad});

  final String nombre;
  final String telefono;
  final int cantidad;
}

/// Ejercicio 5
/// Un Form con tres TextFormField y un botón:
/// 1. Nombre, con key: const Key('nombre'). Error si vacío: 'El nombre es obligatorio'.
/// 2. Teléfono, con key: const Key('telefono'), validado con validarTelefonoHn.
/// 3. Cantidad, con key: const Key('cantidad'), validada con validarCantidad.
/// 4. Un FilledButton 'Enviar pedido'. Si el formulario es válido, llamá a alEnviar con
///    el nombre sin espacios sobrantes, el teléfono normalizado y la cantidad como int.
///    Si no es válido, no llamés a nada: los errores aparecen debajo de cada campo.
class FormularioPedido extends StatefulWidget {
  const FormularioPedido({super.key, required this.alEnviar});

  final ValueChanged<DatosPedido> alEnviar;

  @override
  State<FormularioPedido> createState() => _FormularioPedidoState();
}

class _FormularioPedidoState extends State<FormularioPedido> {
  // TODO: un GlobalKey<FormState> y un TextEditingController por campo.
  // No olvidés liberar los controladores en dispose.

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
