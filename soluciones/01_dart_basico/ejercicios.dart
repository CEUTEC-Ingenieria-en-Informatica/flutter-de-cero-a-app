// Módulo 01 · Dart básico · una solución posible (hay otras).

/// Ejercicio 1
String saludo(String nombre) {
  final limpio = nombre.trim();
  if (limpio.isEmpty) {
    return 'Hola, desconocido';
  }
  return 'Hola, $limpio';
}

/// Ejercicio 2
String formatoLempiras(double monto) {
  return 'L ${monto.toStringAsFixed(2)}';
}

/// Ejercicio 3
double precioConIsv(double precio) {
  const isv = 0.15;
  final total = precio * (1 + isv);
  return (total * 100).round() / 100;
}

/// Ejercicio 4
String clasificarNota(int nota) {
  if (nota < 0 || nota > 100) {
    return 'Nota inválida';
  }
  if (nota >= 90) return 'Excelente';
  if (nota >= 80) return 'Muy bien';
  if (nota >= 70) return 'Bien';
  return 'Reprobado';
}

/// Ejercicio 5
int sumarHasta(int n) {
  var suma = 0;
  for (var i = 1; i <= n; i++) {
    suma += i;
  }
  return suma;
}

/// Ejercicio 6
String tablaDeMultiplicar(int n) {
  final lineas = <String>[];
  for (var i = 1; i <= 10; i++) {
    lineas.add('$n x $i = ${n * i}');
  }
  return lineas.join('\n');
}

/// Ejercicio 7
String diaDeLaSemana(int numero) {
  return switch (numero) {
    1 => 'lunes',
    2 => 'martes',
    3 => 'miércoles',
    4 => 'jueves',
    5 => 'viernes',
    6 => 'sábado',
    7 => 'domingo',
    _ => 'no existe',
  };
}
