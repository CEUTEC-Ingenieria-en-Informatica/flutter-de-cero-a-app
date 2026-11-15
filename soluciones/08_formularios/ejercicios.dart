// Módulo 08 · Formularios y validación · una solución posible (hay otras).
import 'package:flutter/material.dart';

/// Ejercicio 1
String? validarRequerido(String? valor, {String campo = 'Este campo'}) {
  if (valor == null || valor.trim().isEmpty) {
    return '$campo es obligatorio';
  }
  return null;
}

/// Ejercicio 2
String? validarCorreo(String? valor) {
  final requerido = validarRequerido(valor, campo: 'El correo');
  if (requerido != null) return requerido;
  final patron = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!patron.hasMatch(valor!.trim())) {
    return 'Correo no válido';
  }
  return null;
}

/// Ejercicio 3
String normalizarTelefono(String valor) => valor.replaceAll(RegExp(r'[\s-]'), '');

String? validarTelefonoHn(String? valor) {
  final requerido = validarRequerido(valor, campo: 'El teléfono');
  if (requerido != null) return requerido;
  final limpio = normalizarTelefono(valor!);
  if (!RegExp(r'^[23789]\d{7}$').hasMatch(limpio)) {
    return 'Teléfono no válido (8 dígitos)';
  }
  return null;
}

/// Ejercicio 4
String? validarCantidad(String? valor) {
  final numero = int.tryParse(valor?.trim() ?? '');
  if (numero == null) return 'Escribí un número';
  if (numero < 1 || numero > 50) return 'Entre 1 y 50';
  return null;
}

/// Lo que devuelve el formulario cuando todo está bien.
class DatosPedido {
  const DatosPedido({required this.nombre, required this.telefono, required this.cantidad});

  final String nombre;
  final String telefono;
  final int cantidad;
}

/// Ejercicio 5
class FormularioPedido extends StatefulWidget {
  const FormularioPedido({super.key, required this.alEnviar});

  final ValueChanged<DatosPedido> alEnviar;

  @override
  State<FormularioPedido> createState() => _FormularioPedidoState();
}

class _FormularioPedidoState extends State<FormularioPedido> {
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _telefono = TextEditingController();
  final _cantidad = TextEditingController();

  @override
  void dispose() {
    _nombre.dispose();
    _telefono.dispose();
    _cantidad.dispose();
    super.dispose();
  }

  void _enviar() {
    if (!_formulario.currentState!.validate()) return;
    widget.alEnviar(DatosPedido(
      nombre: _nombre.text.trim(),
      telefono: normalizarTelefono(_telefono.text),
      cantidad: int.parse(_cantidad.text.trim()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formulario,
      child: Column(
        children: [
          TextFormField(
            key: const Key('nombre'),
            controller: _nombre,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (v) => validarRequerido(v, campo: 'El nombre'),
          ),
          TextFormField(
            key: const Key('telefono'),
            controller: _telefono,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            keyboardType: TextInputType.phone,
            validator: validarTelefonoHn,
          ),
          TextFormField(
            key: const Key('cantidad'),
            controller: _cantidad,
            decoration: const InputDecoration(labelText: 'Cantidad de pupusas'),
            keyboardType: TextInputType.number,
            validator: validarCantidad,
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _enviar, child: const Text('Enviar pedido')),
        ],
      ),
    );
  }
}
