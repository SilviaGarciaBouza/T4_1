class Producto {
  Producto({
    required this.name,
    required this.precio,
    this.esSeleccionado = false,
  });
  String name;
  double precio;
  bool esSeleccionado;
}
