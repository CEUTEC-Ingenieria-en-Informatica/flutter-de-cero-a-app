// Ejemplo del módulo 08. Para verlo en pantalla:
//   flutter run -t modulos/08_formularios/ejemplo.dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: PantallaInscripcion()));

class PantallaInscripcion extends StatefulWidget {
  const PantallaInscripcion({super.key});

  @override
  State<PantallaInscripcion> createState() => _PantallaInscripcionState();
}

class _PantallaInscripcionState extends State<PantallaInscripcion> {
  // La llave da acceso al estado del Form: validate(), save(), reset().
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _correo = TextEditingController();
  bool _aceptaReglas = false;

  @override
  void dispose() {
    _nombre.dispose();
    _correo.dispose();
    super.dispose();
  }

  void _inscribir() {
    final valido = _formulario.currentState!.validate();
    if (!valido) return;
    if (!_aceptaReglas) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aceptá el código de conducta para seguir')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Listo, ${_nombre.text.trim()}. Te escribimos a ${_correo.text.trim()}')),
    );
    _formulario.currentState!.reset();
    _nombre.clear();
    _correo.clear();
    setState(() => _aceptaReglas = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscripción al taller')),
      body: Form(
        key: _formulario,
        // Valida mientras escribís, pero solo después de que el usuario tocó el campo.
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombre,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Nombre completo', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribí tu nombre' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _correo,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Correo', border: OutlineInputBorder()),
              validator: (v) {
                final texto = v?.trim() ?? '';
                if (texto.isEmpty) return 'Escribí tu correo';
                if (!texto.contains('@')) return 'A ese correo le falta la arroba';
                return null;
              },
            ),
            CheckboxListTile(
              value: _aceptaReglas,
              onChanged: (v) => setState(() => _aceptaReglas = v ?? false),
              title: const Text('Acepto el código de conducta'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            FilledButton(onPressed: _inscribir, child: const Text('Inscribirme')),
          ],
        ),
      ),
    );
  }
}
