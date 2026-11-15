// Ejemplo del módulo 03. Corrélo con: dart run modulos/03_clases_y_null_safety/ejemplo.dart
// ignore_for_file: avoid_print

class Mascota {
  // Constructor corto: this.nombre asigna directo al campo.
  Mascota(this.nombre, {this.raza, int edad = 0}) : _edad = edad;

  // Constructor con nombre: otra forma de crear el objeto.
  Mascota.adoptada(String nombre) : this(nombre, raza: 'Criolla');

  final String nombre;
  final String? raza; // puede ser null: no todas tienen raza conocida
  int _edad; // privado: solo se cambia desde esta biblioteca

  int get edad => _edad;

  void cumplirAnios() => _edad++;

  String describir() {
    // ?? da un valor por si raza es null.
    return '$nombre, ${raza ?? 'raza desconocida'}, $_edad años';
  }

  @override
  String toString() => 'Mascota($nombre)';
}

// Herencia: Perro es una Mascota con algo más.
class Perro extends Mascota {
  Perro(super.nombre, {super.raza});

  String ladrar() => '$nombre dice guau';
}

void main() {
  final firulais = Perro('Firulais', raza: 'Aguacatero');
  final mishi = Mascota.adoptada('Mishi');
  final sinDatos = Mascota('Pelusa');

  firulais.cumplirAnios();
  print(firulais.describir());
  print(firulais.ladrar());
  print(mishi.describir());
  print(sinDatos.describir());

  // Null safety en acción.
  final apodo = apodoDe('Mishi'); // String?, y en este caso vale null
  print(apodo?.length); // null, sin reventar
  print(apodo ?? 'sin apodo'); // sin apodo

  final otro = apodoDe('Firulais');
  if (otro != null) {
    // Dentro del if, Dart ya sabe que otro no es null (promoción de tipo).
    print(otro.toUpperCase());
  }
}

// Devuelve String? porque no todas las mascotas tienen apodo.
String? apodoDe(String nombre) => nombre == 'Firulais' ? 'Firu' : null;
