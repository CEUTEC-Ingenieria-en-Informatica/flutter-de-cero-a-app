// Módulo 12 · Proyecto final · modelos (ya están listos, no hace falta cambiarlos).
//
// Pupusería El Comal Alegre es un negocio inventado para este curso.

enum Categoria { pupusas, bebidas }

class Producto {
  const Producto({required this.id, required this.nombre, required this.precio, required this.categoria});

  final String id;
  final String nombre;
  final double precio;
  final Categoria categoria;

  @override
  String toString() => 'Producto($id)';
}

const menu = [
  Producto(id: 'revuelta', nombre: 'Revuelta', precio: 25, categoria: Categoria.pupusas),
  Producto(id: 'queso', nombre: 'Queso', precio: 22, categoria: Categoria.pupusas),
  Producto(id: 'frijol_queso', nombre: 'Frijol con queso', precio: 22, categoria: Categoria.pupusas),
  Producto(id: 'loroco', nombre: 'Loroco con queso', precio: 28, categoria: Categoria.pupusas),
  Producto(id: 'chicharron', nombre: 'Chicharrón', precio: 25, categoria: Categoria.pupusas),
  Producto(id: 'ayote', nombre: 'Ayote con queso', precio: 24, categoria: Categoria.pupusas),
  Producto(id: 'horchata', nombre: 'Horchata', precio: 20, categoria: Categoria.bebidas),
  Producto(id: 'cafe', nombre: 'Café de palo', precio: 15, categoria: Categoria.bebidas),
  Producto(id: 'chocolate', nombre: 'Chocolate caliente', precio: 18, categoria: Categoria.bebidas),
];

/// Busca un producto del menú por su id.
Producto productoPorId(String id) => menu.firstWhere((p) => p.id == id);

/// Redondea a centavos.
double redondear(double monto) => (monto * 100).round() / 100;

/// 25 se escribe 'L 25.00'.
String lempiras(double monto) => 'L ${monto.toStringAsFixed(2)}';

/// Tasa del ISV que se usa en el curso.
const tasaIsv = 0.15;

/// Desde cuántas pupusas aplica la promoción, y de cuánto es.
const pupusasParaPromo = 12;
const descuentoPromo = 0.10;
