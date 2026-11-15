// Módulo 12 · Proyecto final · las pantallas · una solución posible (hay otras).
import 'package:flutter/material.dart';

import '../../modulos/12_proyecto_final/modelos.dart';
import 'pedido.dart';

class AppPupuseria extends StatefulWidget {
  const AppPupuseria({super.key, this.pedido});

  /// Los tests mandan su propio pedido. La app real crea uno.
  final Pedido? pedido;

  @override
  State<AppPupuseria> createState() => _AppPupuseriaState();
}

class _AppPupuseriaState extends State<AppPupuseria> {
  late final Pedido _pedido = widget.pedido ?? Pedido();

  @override
  void dispose() {
    if (widget.pedido == null) _pedido.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Comal Alegre',
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange),
      home: PantallaMenu(pedido: _pedido),
    );
  }
}

/// Pantalla 1
class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key, required this.pedido});

  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El Comal Alegre'),
        actions: [
          ListenableBuilder(
            listenable: pedido,
            builder: (context, _) => IconButton(
              key: const Key('ver_pedido'),
              icon: Badge(
                isLabelVisible: pedido.totalArticulos > 0,
                label: Text('${pedido.totalArticulos}', key: const Key('contador_pedido')),
                child: const Icon(Icons.shopping_bag),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (_) => PantallaPedido(pedido: pedido)),
              ),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: pedido,
        builder: (context, _) => ListView(
          children: [
            for (final categoria in Categoria.values) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  categoria == Categoria.pupusas ? 'Pupusas' : 'Bebidas',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              for (final p in menu.where((p) => p.categoria == categoria))
                ListTile(
                  title: Text(p.nombre),
                  subtitle: Text(lempiras(p.precio)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        key: Key('quitar_${p.id}'),
                        icon: const Icon(Icons.remove),
                        onPressed: pedido.cantidadDe(p) == 0 ? null : () => pedido.quitar(p),
                      ),
                      Text('${pedido.cantidadDe(p)}', key: Key('cantidad_${p.id}')),
                      IconButton(
                        key: Key('agregar_${p.id}'),
                        icon: const Icon(Icons.add),
                        onPressed: () => pedido.agregar(p),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Pantalla 2
class PantallaPedido extends StatefulWidget {
  const PantallaPedido({super.key, required this.pedido});

  final Pedido pedido;

  @override
  State<PantallaPedido> createState() => _PantallaPedidoState();
}

class _PantallaPedidoState extends State<PantallaPedido> {
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _telefono = TextEditingController();

  @override
  void dispose() {
    _nombre.dispose();
    _telefono.dispose();
    super.dispose();
  }

  void _confirmar() {
    if (!_formulario.currentState!.validate()) return;
    final nombre = _nombre.text.trim();
    final total = widget.pedido.total;
    widget.pedido.vaciar();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => PantallaConfirmacion(nombre: nombre, total: total)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pedido = widget.pedido;
    return Scaffold(
      appBar: AppBar(title: const Text('Tu pedido')),
      body: pedido.estaVacio
          ? const Center(child: Text('Todavía no agregaste nada'))
          : Form(
              key: _formulario,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final (p, c) in pedido.lineas)
                    Row(
                      children: [
                        Expanded(child: Text('$c x ${p.nombre}')),
                        Text(lempiras(p.precio * c)),
                      ],
                    ),
                  const Divider(),
                  Text('Subtotal: ${lempiras(pedido.subtotal)}', key: const Key('subtotal')),
                  if (pedido.descuento > 0)
                    Text('Descuento: ${lempiras(pedido.descuento)}', key: const Key('descuento')),
                  Text('ISV (15 %): ${lempiras(pedido.isv)}', key: const Key('isv')),
                  Text('Total: ${lempiras(pedido.total)}', key: const Key('total')),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('nombre'),
                    controller: _nombre,
                    decoration: const InputDecoration(labelText: 'Tu nombre'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Escribí tu nombre' : null,
                  ),
                  TextFormField(
                    key: const Key('telefono'),
                    controller: _telefono,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Teléfono'),
                    validator: (v) {
                      final limpio = (v ?? '').replaceAll(RegExp(r'[\s-]'), '');
                      return RegExp(r'^[23789]\d{7}$').hasMatch(limpio) ? null : 'Teléfono de 8 dígitos';
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: _confirmar, child: const Text('Confirmar pedido')),
                ],
              ),
            ),
    );
  }
}

/// Pantalla 3
class PantallaConfirmacion extends StatelessWidget {
  const PantallaConfirmacion({super.key, required this.nombre, required this.total});

  final String nombre;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedido recibido'), automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 64),
            const SizedBox(height: 16),
            Text('Gracias, $nombre'),
            Text('Total a pagar: ${lempiras(total)}'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hacer otro pedido'),
            ),
          ],
        ),
      ),
    );
  }
}
