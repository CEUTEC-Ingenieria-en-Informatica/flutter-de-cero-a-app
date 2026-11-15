// Ejemplo del módulo 11: código pensado para poder probarse.
// Los tests de este ejemplo están en el README, en "Ejemplo explicado".
import 'package:flutter/material.dart';

/// Lógica pura: sin widgets, sin red, sin reloj. Se prueba con test() en milisegundos.
double calcularPropina(double cuenta, {double porcentaje = 10}) {
  if (cuenta < 0) throw ArgumentError.value(cuenta, 'cuenta', 'no puede ser negativa');
  return (cuenta * porcentaje).round() / 100;
}

/// Un widget pequeño con una key en lo que el test necesita encontrar.
class CalculadoraPropina extends StatefulWidget {
  const CalculadoraPropina({super.key});

  @override
  State<CalculadoraPropina> createState() => _CalculadoraPropinaState();
}

class _CalculadoraPropinaState extends State<CalculadoraPropina> {
  double _propina = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('cuenta'),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Cuenta en lempiras'),
          onChanged: (texto) {
            final cuenta = double.tryParse(texto) ?? 0;
            setState(() => _propina = cuenta < 0 ? 0 : calcularPropina(cuenta));
          },
        ),
        Text('Propina: L ${_propina.toStringAsFixed(2)}', key: const Key('propina')),
      ],
    );
  }
}

void main() => runApp(const MaterialApp(home: Scaffold(body: CalculadoraPropina())));
