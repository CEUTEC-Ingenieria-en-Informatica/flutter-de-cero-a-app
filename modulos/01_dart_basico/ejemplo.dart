// Ejemplo del módulo 01. Corrélo con: dart run modulos/01_dart_basico/ejemplo.dart
// ignore_for_file: avoid_print

void main() {
  // var deja que Dart adivine el tipo; final no se puede reasignar; const se conoce al compilar.
  var pupusas = 3;
  final precioUnidad = 25.0;
  const isv = 0.15;
  String cliente = 'Rosa';

  pupusas = pupusas + 2; // var sí se puede cambiar

  final subtotal = pupusas * precioUnidad;
  final total = subtotal * (1 + isv);

  // Interpolación: $variable o ${expresión}
  print('$cliente pidió $pupusas pupusas.');
  print('Subtotal: L ${subtotal.toStringAsFixed(2)}');
  print('Total con ISV: L ${total.toStringAsFixed(2)}');

  // if y else
  if (total > 100) {
    print('Le toca curtido extra.');
  } else {
    print('Pedido normal.');
  }

  // for clásico
  for (var i = 1; i <= 3; i++) {
    print('Saliendo la pupusa $i');
  }

  // switch como expresión (Dart 3)
  const hora = 19;
  final turno = switch (hora) {
    < 12 => 'mañana',
    < 18 => 'tarde',
    _ => 'noche',
  };
  print('Turno: $turno');
}
