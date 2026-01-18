/// Clase que representa un artículo del catálogo del bar.
class Producto {
  Producto({
    required this.name,
    required this.precio,
    this.esSeleccionado = false,
    this.cantidad = 0,
  });

  /// Nombre del producto.
  String name;

  /// Precio en euros.
  double precio;

  /// Estado para controlar si el producto ha sido seleccionado en la interfaz.
  bool esSeleccionado;

  /// Cantidad de unidades seleccionadas de este producto.
  int cantidad;
}
