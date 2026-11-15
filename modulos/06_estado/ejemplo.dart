// Ejemplo del módulo 06. Para verlo en pantalla:
//   flutter run -t modulos/06_estado/ejemplo.dart
import 'package:flutter/material.dart';

/// Estado compartido: la lista de tareas vive fuera de los widgets.
class ListaTareas extends ChangeNotifier {
  final List<String> _tareas = [];

  List<String> get tareas => List.unmodifiable(_tareas);

  void agregar(String tarea) {
    _tareas.add(tarea);
    notifyListeners(); // avisa a quien esté escuchando
  }

  void completar(int indice) {
    _tareas.removeAt(indice);
    notifyListeners();
  }
}

void main() => runApp(const AppTareas());

class AppTareas extends StatefulWidget {
  const AppTareas({super.key});

  @override
  State<AppTareas> createState() => _AppTareasState();
}

class _AppTareasState extends State<AppTareas> {
  // El modelo y el ValueNotifier se crean una vez y se liberan en dispose.
  final _lista = ListaTareas();
  final _oscuro = ValueNotifier(false);

  @override
  void dispose() {
    _lista.dispose();
    _oscuro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder reconstruye solo lo de adentro cuando cambia _oscuro.
    return ValueListenableBuilder<bool>(
      valueListenable: _oscuro,
      builder: (context, oscuro, _) => MaterialApp(
        theme: ThemeData(brightness: oscuro ? Brightness.dark : Brightness.light),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Tareas del proyecto'),
            actions: [
              Switch(value: oscuro, onChanged: (v) => _oscuro.value = v),
            ],
          ),
          body: Column(
            children: [
              CampoNuevaTarea(alAgregar: _lista.agregar),
              Expanded(
                // ListenableBuilder escucha al ChangeNotifier.
                child: ListenableBuilder(
                  listenable: _lista,
                  builder: (context, _) => ListView.builder(
                    itemCount: _lista.tareas.length,
                    itemBuilder: (context, i) => CheckboxListTile(
                      value: false,
                      title: Text(_lista.tareas[i]),
                      onChanged: (_) => _lista.completar(i),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Estado local: lo que se escribe en el campo solo le importa a este widget.
class CampoNuevaTarea extends StatefulWidget {
  const CampoNuevaTarea({super.key, required this.alAgregar});

  final ValueChanged<String> alAgregar;

  @override
  State<CampoNuevaTarea> createState() => _CampoNuevaTareaState();
}

class _CampoNuevaTareaState extends State<CampoNuevaTarea> {
  final _controlador = TextEditingController();
  bool _hayTexto = false;

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  void _agregar() {
    widget.alAgregar(_controlador.text.trim());
    _controlador.clear();
    setState(() => _hayTexto = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controlador,
              decoration: const InputDecoration(labelText: 'Nueva tarea'),
              onChanged: (texto) => setState(() => _hayTexto = texto.trim().isNotEmpty),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _hayTexto ? _agregar : null,
          ),
        ],
      ),
    );
  }
}
