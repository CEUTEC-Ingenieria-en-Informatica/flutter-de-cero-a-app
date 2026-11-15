// Ejemplo del módulo 02. Corrélo con: dart run modulos/02_funciones_y_colecciones/ejemplo.dart
// ignore_for_file: avoid_print

// Función normal con tipo de retorno.
double subtotal(int cantidad, double precio) {
  return cantidad * precio;
}

// Función flecha: para cuando el cuerpo es una sola expresión.
String moneda(double monto) => 'L ${monto.toStringAsFixed(2)}';

// Parámetros con nombre: se leen mejor al llamar. required obliga a mandarlo.
String etiqueta({required String nombre, int existencia = 0}) =>
    existencia > 0 ? '$nombre ($existencia disponibles)' : '$nombre (agotado)';

void main() {
  // List: ordenada, permite repetidos.
  final pedidos = <String>['revuelta', 'queso', 'revuelta', 'loroco'];

  // Map: clave y valor.
  final precios = <String, double>{'revuelta': 25, 'queso': 22, 'loroco': 28};

  // Set: sin repetidos.
  final sabores = pedidos.toSet();
  print('Sabores distintos: $sabores');

  // map transforma cada elemento; where filtra; fold acumula.
  final montos = pedidos.map((sabor) => precios[sabor] ?? 0).toList();
  final caros = pedidos.where((sabor) => (precios[sabor] ?? 0) > 24).toList();
  final total = montos.fold(0.0, (suma, m) => suma + m);

  print('Montos: $montos');
  print('Más de L 24: $caros');
  print('Total: ${moneda(total)}');
  print('Subtotal de 3 de queso: ${moneda(subtotal(3, 22))}');
  print(etiqueta(nombre: 'Horchata', existencia: 4));
  print(etiqueta(nombre: 'Chocolate'));

  // Recorrer un Map.
  for (final entrada in precios.entries) {
    print('${entrada.key} cuesta ${moneda(entrada.value)}');
  }

  // Colecciones con if y for adentro.
  const conBebida = true;
  final combo = ['revuelta', 'queso', if (conBebida) 'horchata'];
  final dobles = [for (final p in combo) '$p x2'];
  print(dobles);
}
