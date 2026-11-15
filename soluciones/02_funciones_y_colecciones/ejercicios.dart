// Módulo 02 · Funciones y colecciones · una solución posible (hay otras).

/// Ejercicio 1
double sumarPrecios(List<double> precios) {
  return precios.fold(0.0, (acumulado, precio) => acumulado + precio);
}

/// Ejercicio 2
List<String> enMayuscula(List<String> nombres) {
  return nombres.map((n) => n.toUpperCase()).toList();
}

/// Ejercicio 3
List<int> soloPares(List<int> numeros) {
  return numeros.where((n) => n.isEven).toList();
}

/// Ejercicio 4
String describirPlato(String nombre, {double precio = 0, bool picante = false}) {
  final base = '$nombre: L ${precio.toStringAsFixed(2)}';
  return picante ? '$base (picante)' : base;
}

/// Ejercicio 5
double aplicarDescuento(double precio, [double porcentaje = 10]) {
  return precio - precio * porcentaje / 100;
}

/// Ejercicio 6
Map<String, int> contarPalabras(String texto) {
  final conteo = <String, int>{};
  final palabras = texto.toLowerCase().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
  for (final palabra in palabras) {
    conteo[palabra] = (conteo[palabra] ?? 0) + 1;
  }
  return conteo;
}

/// Ejercicio 7
Set<String> ingredientesUnicos(List<List<String>> recetas) {
  return {
    for (final receta in recetas)
      for (final ingrediente in receta) ingrediente.trim().toLowerCase(),
  };
}

/// Ejercicio 8
List<String> masVendidos(Map<String, int> ventas, int cuantos) {
  final entradas = ventas.entries.toList()
    ..sort((a, b) {
      final porCantidad = b.value.compareTo(a.value);
      return porCantidad != 0 ? porCantidad : a.key.compareTo(b.key);
    });
  return entradas.take(cuantos).map((e) => e.key).toList();
}
