// Módulo 11 · Tests · ejercicios
//
// Aquí se trabaja al revés: primero leé el test (test/m11_tests_test.dart), que es la especificación,
// y después escribí el código que lo hace pasar.
// Para revisar solo este módulo: flutter test test/m11_tests_test.dart
//
// Para el ejercicio 4 vas a necesitar Timer: agregá import 'dart:async';
import 'package:flutter/material.dart';

/// Ejercicio 1
/// La pupusería abre de lunes a sábado de 7:00 a 21:00 y el domingo de 8:00 a 14:00.
/// A la hora de cierre exacta ya está cerrada (21:00 es cerrado; 20:59 es abierto).
/// Pista: DateTime.sunday, momento.weekday, hour y minute.
bool estaAbierto(DateTime momento) {
  // TODO
  throw UnimplementedError('TODO ejercicio 1');
}

/// Ejercicio 2
/// Un saludo que depende de la hora: antes de las 12 'Buenos días', antes de las 18 'Buenas tardes'
/// y si no 'Buenas noches'.
/// El reloj se recibe por el constructor para poder probarlo. Si no mandan uno, usá DateTime.now.
class SaludoDelDia {
  // TODO: guardá la función que da la hora (ahora ?? DateTime.now) en un campo privado.
  SaludoDelDia({DateTime Function()? ahora});

  String saludo() {
    // TODO: no llamés DateTime.now() aquí directo, usá la función guardada.
    throw UnimplementedError('TODO ejercicio 2');
  }
}

/// Ejercicio 3
/// Esta función YA ESTÁ ESCRITA, pero tiene errores. Tu trabajo:
/// 1. Escribí primero un test tuyo en test/practica/mis_tests_test.dart que lo demuestre.
/// 2. Arreglá la función hasta que pasen tu test y el del curso.
///
/// Qué debería hacer: dado el total y lo que pagó el cliente (en lempiras enteros),
/// devolver cuántos billetes o monedas de cada denominación hay que dar de vuelto,
/// usando siempre la más grande posible y sin incluir las que quedan en cero.
/// Si lo pagado no alcanza, lanza ArgumentError. Si pagó exacto, el vuelto es un mapa vacío.
const denominaciones = [500, 200, 100, 50, 10, 5, 2, 1];

Map<int, int> desgloseVuelto(int total, int pagado) {
  if (pagado <= total) {
    throw ArgumentError('Lo pagado no alcanza');
  }
  var resto = pagado - total;
  final desglose = <int, int>{};
  for (final d in denominaciones) {
    final cuantos = resto ~/ d;
    if (cuantos > 0) {
      desglose[d] = cuantos;
      resto -= cuantos * d;
    }
  }
  return desglose;
}

/// Ejercicio 4
/// Un campo de búsqueda que no busca en cada tecla: espera a que la persona deje de escribir.
/// 1. Un TextField con labelText 'Buscar'.
/// 2. Cada vez que cambia el texto, reiniciá un Timer de [espera].
/// 3. Cuando el Timer se cumple, llamá a alBuscar con el texto sin espacios sobrantes.
/// 4. Cancelá el Timer en dispose.
class CampoBusqueda extends StatefulWidget {
  const CampoBusqueda({
    super.key,
    required this.alBuscar,
    this.espera = const Duration(milliseconds: 300),
  });

  final ValueChanged<String> alBuscar;
  final Duration espera;

  @override
  State<CampoBusqueda> createState() => _CampoBusquedaState();
}

class _CampoBusquedaState extends State<CampoBusqueda> {
  // TODO: Timer? _temporizador;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
