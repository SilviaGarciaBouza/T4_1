import 'Pedido.dart';
import 'Producto.dart';

/// Clase con la lógica de negocio y almacenamiento de los datos del bar.
class BarModel {
  List<Pedido> listaPedidos = [
    Pedido(mesaId: 1, numProductos: 5, totalEuros: 23.4),
    Pedido(mesaId: 2, numProductos: 4, totalEuros: 20.5),
  ];

  /// Método que busca un [Pedido] por el id de la mesa.
  /// Retorna null si no se encuentra el pedido (maneja los errores mediante try-catch).
  Pedido? getPedido(int mesaId) {
    try {
      return listaPedidos.firstWhere((pedido) => pedido.mesaId == mesaId);
    } catch (e) {
      return null;
    }
  }

  /// Método que añade un nuevo [Pedido] a la [listaPedidos].
  void addPedido(Pedido p) {
    listaPedidos.add(p);
  }

  /// Método que transforma una lista de [Producto] seleccionados en un objeto [Pedido],
  /// calculando la suma de los precios y el número de objetos [Producto]
  Pedido crearPedido(int idMesa, List<Producto> listaProductos) {
    double totalEuros = 0;
    int numeroProductosTotal = 0;
    for (Producto producto in listaProductos) {
      totalEuros += producto.precio * producto.cantidad;
      numeroProductosTotal += producto.cantidad;
    }
    return Pedido(
      mesaId: idMesa,
      numProductos: numeroProductosTotal,
      totalEuros: totalEuros,
    );
  }

  /// Catálogo de productos disponibles en el bar.
  List<Producto> listaProductos = [
    Producto(name: "Cafe", precio: 1.5),
    Producto(name: "Descafeinado", precio: 2.3),
    Producto(name: "Espresso", precio: 2.0),
    Producto(name: "Cappuccino", precio: 1.4),
    Producto(name: "Mocha", precio: 2.8),
    Producto(name: "Té", precio: 1.7),
    Producto(name: "Tila", precio: 1.5),
    Producto(name: "Manzanilla", precio: 2.3),
    Producto(name: "Menta", precio: 2.0),
    Producto(name: "Rooibos", precio: 1.4),
    Producto(name: "Batido", precio: 2.8),
    Producto(name: "Zumo", precio: 1.7),
    Producto(name: "Agua", precio: 1.7),
  ];

  /// Método que añade un nuevo [Producto] a la lista [listaProductos].
  void addProducto(Producto p) {
    listaProductos.add(p);
  }
}
