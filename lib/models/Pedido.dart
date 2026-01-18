/// Clase que representa la información de una comanda.
class Pedido {
  Pedido({
    required this.mesaId,
    required this.numProductos,
    required this.totalEuros,
  });

  /// Identificador numérico de la mesa.
  int mesaId;

  /// Suma total de unidades de todos los productos del pedido.
  int numProductos;

  /// Coste total de la comanda.
  double totalEuros;
}
