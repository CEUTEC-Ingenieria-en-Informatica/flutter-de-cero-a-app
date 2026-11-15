// Ejemplo del módulo 07. Para verlo en pantalla:
//   flutter run -t modulos/07_navegacion/ejemplo.dart
import 'package:flutter/material.dart';

void main() => runApp(const AppEventos());

class Evento {
  const Evento(this.nombre, this.lugar);
  final String nombre;
  final String lugar;
}

const eventos = [
  Evento('Taller de Flutter', 'Laboratorio 3'),
  Evento('Charla de diseño UI', 'Auditorio'),
  Evento('Hackatón de fin de mes', 'Biblioteca'),
];

class AppEventos extends StatelessWidget {
  const AppEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Rutas con nombre: útiles para pantallas a las que se llega desde muchos lados.
      routes: {
        '/': (_) => const PantallaEventos(),
        '/ajustes': (_) => const PantallaAjustes(),
      },
    );
  }
}

class PantallaEventos extends StatelessWidget {
  const PantallaEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/ajustes'),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final e in eventos)
            ListTile(
              title: Text(e.nombre),
              subtitle: Text(e.lugar),
              onTap: () async {
                // push devuelve un Future con lo que la otra pantalla mande en pop.
                final confirmado = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => PantallaDetalleEvento(evento: e)),
                );
                // Después de un await, revisá que el contexto siga vivo antes de usarlo.
                if (!context.mounted || confirmado != true) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Te inscribiste en ${e.nombre}')),
                );
              },
            ),
        ],
      ),
    );
  }
}

class PantallaDetalleEvento extends StatelessWidget {
  const PantallaDetalleEvento({super.key, required this.evento});

  // Los datos se pasan por el constructor, como a cualquier widget.
  final Evento evento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(evento.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lugar: ${evento.lugar}'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Inscribirme'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaAjustes extends StatelessWidget {
  const PantallaAjustes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: const Center(child: Text('Aquí irían las preferencias')),
    );
  }
}
