// Módulo 07 · Navegación · una solución posible (hay otras).
import 'package:flutter/material.dart';

/// Ejercicio 1
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
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (_) => PantallaDetalle(plato: plato)),
                );
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
    return Scaffold(
      appBar: AppBar(title: Text(plato)),
      body: Center(child: Text('Detalle de $plato')),
    );
  }
}

/// Ejercicio 2
class PantallaElegirTamano extends StatelessWidget {
  const PantallaElegirTamano({super.key});

  static const tamanos = ['Pequeño', 'Mediano', 'Grande'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elegí el tamaño')),
      body: ListView(
        children: [
          for (final t in tamanos) ListTile(title: Text(t), onTap: () => Navigator.pop(context, t)),
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
  String _tamano = 'ninguno';

  Future<void> _elegir() async {
    final elegido = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const PantallaElegirTamano()),
    );
    if (!mounted || elegido == null) return;
    setState(() => _tamano = elegido);
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
class AppConRutas extends StatelessWidget {
  const AppConRutas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const PantallaPortada(),
        '/acerca': (_) => const PantallaAcerca(),
      },
    );
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
          onPressed: () => Navigator.pushNamed(context, '/acerca'),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de')),
      body: const Center(child: Text('Hecho por la comunidad')),
    );
  }
}

/// Ejercicio 4
class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(builder: (_) => const PantallaPrincipal()),
            );
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
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: const Center(child: Text('Ya estás adentro')),
    );
  }
}
