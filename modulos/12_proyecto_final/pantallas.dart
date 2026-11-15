// Módulo 12 · Proyecto final · las pantallas
//
// AppPupuseria ya está lista. Te tocan las tres pantallas. Los textos y las Key exactas importan:
// los tests buscan con ellas.
import 'package:flutter/material.dart';

// Lo vas a usar para menu, lempiras y Categoria. Cuando lo usés, borrá la línea del ignore.
// ignore: unused_import
import '../../modulos/12_proyecto_final/modelos.dart';
import 'pedido.dart';

/// Ya está lista: crea el pedido (o usa el que le mandan los tests) y abre el menú.
class AppPupuseria extends StatefulWidget {
  const AppPupuseria({super.key, this.pedido});

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

/// Pantalla 1 · el menú
/// 1. AppBar con el título 'El Comal Alegre'.
/// 2. En las acciones del AppBar, un IconButton con key: const Key('ver_pedido') y el ícono
///    Icons.shopping_bag. Mostrá cuántos artículos lleva el pedido con un Badge cuyo label es un Text
///    con key: const Key('contador_pedido') (el Badge solo se ve si hay más de 0).
///    Al tocarlo, abre PantallaPedido con push.
/// 3. En el cuerpo, una lista con dos secciones, 'Pupusas' y 'Bebidas', y un ListTile por producto:
///    title el nombre, subtitle el precio con lempiras(), y trailing un Row con:
///    a. IconButton Icons.remove con `Key('quitar_<id>')`, desactivado si la cantidad es 0.
///    b. Text con la cantidad y `Key('cantidad_<id>')`.
///    c. IconButton Icons.add con `Key('agregar_<id>')`.
///    Por ejemplo, para la revuelta las keys son 'quitar_revuelta', 'cantidad_revuelta' y 'agregar_revuelta'.
/// 4. Todo lo que muestra datos del pedido se redibuja con ListenableBuilder.
class PantallaMenu extends StatelessWidget {
  const PantallaMenu({super.key, required this.pedido});

  final Pedido pedido;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Pantalla 2 · el pedido
/// 1. AppBar con el título 'Tu pedido'.
/// 2. Si el pedido está vacío, solo el texto centrado 'Todavía no agregaste nada'.
/// 3. Si no, dentro de un Form con ListView:
///    a. Una fila por línea: '2 x Revuelta' a la izquierda y lo que suma esa línea a la derecha.
///    b. Los montos, cada uno con su Key:
///       Key('subtotal') 'Subtotal: L 50.00'
///       Key('descuento') 'Descuento: L 30.00' (solo si hay descuento)
///       Key('isv') 'ISV (15 %): L 7.50'
///       Key('total') 'Total: L 57.50'
///    c. Un TextFormField con Key('nombre'): si está vacío, error 'Escribí tu nombre'.
///    d. Un TextFormField con Key('telefono'): sin espacios ni guiones debe tener 8 dígitos y empezar con
///       2, 3, 7, 8 o 9; si no, error 'Teléfono de 8 dígitos'. Podés copiar la idea del módulo 08.
///    e. Un FilledButton 'Confirmar pedido'. Si el formulario es válido: guardá el nombre y el total,
///       vaciá el pedido y abrí PantallaConfirmacion con pushReplacement.
class PantallaPedido extends StatefulWidget {
  const PantallaPedido({super.key, required this.pedido});

  final Pedido pedido;

  @override
  State<PantallaPedido> createState() => _PantallaPedidoState();
}

class _PantallaPedidoState extends State<PantallaPedido> {
  // TODO: GlobalKey<FormState> y dos TextEditingController (liberalos en dispose).

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}

/// Pantalla 3 · confirmación
/// Un Scaffold con AppBar 'Pedido recibido' (sin flecha de volver: automaticallyImplyLeading: false)
/// y centrados: Icons.check_circle, 'Gracias, ' más el nombre, 'Total a pagar: L 57.50'
/// y un FilledButton 'Hacer otro pedido' que hace pop y vuelve al menú.
class PantallaConfirmacion extends StatelessWidget {
  const PantallaConfirmacion({super.key, required this.nombre, required this.total});

  final String nombre;
  final double total;

  @override
  Widget build(BuildContext context) {
    // TODO
    return const Placeholder();
  }
}
