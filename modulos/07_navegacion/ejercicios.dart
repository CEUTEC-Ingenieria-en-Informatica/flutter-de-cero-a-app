// Módulo 07 · Navegación · ejercicios
//
// Las pantallas ya están armadas a medias. Te toca conectar la navegación.
// Para revisar solo este módulo: flutter test test/m07_navegacion_test.dart
import 'package:flutter/material.dart';

/// Ejercicio 1
/// 1. Al tocar un plato, abrí PantallaDetalle con Navigator.push y MaterialPageRoute.
/// 2. PantallaDetalle es un Scaffold con el nombre del plato como título del AppBar
///    y, centrado en el cuerpo, el texto 'Detalle de ' más el plato.
/// La flecha para volver la pone el AppBar solo.
class PantallaLista extends StatelessWidget {
  const PantallaLista({super.key, required this.platos});

  final List<String> platos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platos')),
      body: ListView(
        children: [
          for (final plato in platos)
            ListTile(
              title: Text(plato),
              onTap: () {
                // TODO: navegá a PantallaDetalle.
              },
            ),
        ],
      ),
    );
  }
}

class PantallaDetalle extends StatelessWidget {
  const PantallaDetalle({super.key, required this.plato});

  final String plato;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 2
/// Devolver un dato al volver.
/// 1. En PantallaElegirTamano, al tocar un tamaño, cerrá la pantalla devolviendo ese texto
///    con Navigator.pop(context, valor).
/// 2. En BotonTamano, el botón abre PantallaElegirTamano con `await Navigator.push<String>(...)`
///    y muestra 'Tamaño: Grande' (o el que elijan).
/// 3. Si vuelven con la flecha sin elegir, llega null: no cambiés nada.
class PantallaElegirTamano extends StatelessWidget {
  const PantallaElegirTamano({super.key});

  static const tamanos = ['Pequeño', 'Mediano', 'Grande'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elegí el tamaño')),
      body: ListView(
        children: [
          for (final t in tamanos)
            ListTile(
              title: Text(t),
              onTap: () {
                // TODO: cerrá devolviendo t.
              },
            ),
        ],
      ),
    );
  }
}

class BotonTamano extends StatefulWidget {
  const BotonTamano({super.key});

  @override
  State<BotonTamano> createState() => _BotonTamanoState();
}

class _BotonTamanoState extends State<BotonTamano> {
  final String _tamano = 'ninguno'; // TODO: va a cambiar, así que no puede quedar final.

  Future<void> _elegir() async {
    // TODO: abrí la pantalla, esperá el resultado y, si no es null, guardalo con setState.
    // Antes de setState revisá `mounted`: el widget pudo desaparecer mientras esperabas.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Tamaño: $_tamano'),
        ElevatedButton(onPressed: _elegir, child: const Text('Elegir tamaño')),
      ],
    );
  }
}

/// Ejercicio 3
/// Rutas con nombre.
/// 1. AppConRutas declara en el MaterialApp las rutas '/' (PantallaPortada) y '/acerca' (PantallaAcerca).
/// 2. El botón 'Ver más' de la portada navega con Navigator.pushNamed(context, '/acerca').
/// 3. PantallaAcerca tiene el título 'Acerca de' y en el cuerpo 'Hecho por la comunidad'.
class AppConRutas extends StatelessWidget {
  const AppConRutas({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: usá initialRoute y routes en vez de home.
    return const MaterialApp(home: PantallaPortada());
  }
}

class PantallaPortada extends StatelessWidget {
  const PantallaPortada({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portada')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // TODO
          },
          child: const Text('Ver más'),
        ),
      ),
    );
  }
}

class PantallaAcerca extends StatelessWidget {
  const PantallaAcerca({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Ejercicio 4
/// Reemplazar una pantalla. Después de "entrar", no se debe poder volver a la bienvenida.
/// El botón 'Entrar' usa Navigator.pushReplacement para abrir PantallaPrincipal,
/// que tiene el título 'Inicio' y el texto 'Ya estás adentro'.
class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            // TODO
          },
          child: const Text('Entrar'),
        ),
      ),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
