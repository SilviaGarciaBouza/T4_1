class Producto {
  Producto({
    required this.name,
    required this.precio,
    this.esSeleccionado = false,
    this.cantidad = 0,
  });
  String name;
  double precio;
  bool esSeleccionado;
  int cantidad;
}
