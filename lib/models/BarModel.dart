import 'Pedido.dart';
import 'Producto.dart';

class BarModel {
  List<Pedido> listaPedidos = [
    Pedido(mesaId: 1, numProductos: 5, totalEuros: 23.4),
    Pedido(mesaId: 2, numProductos: 4, totalEuros: 20.5),
  ];

  Pedido? getPedido(int mesaId) {
    try {
      return listaPedidos.firstWhere((pedido) => pedido.mesaId == mesaId);
    } catch (e) {
      return null;
    }
  }

  void addPedido(Pedido p) {
    listaPedidos.add(p);
  }

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

  List<Producto> listaProductos = [
    Producto(name: "Cafe", precio: 1.5),
    Producto(name: "Zumo", precio: 2.3),
    Producto(name: "Chocolate", precio: 2.0),
    Producto(name: "Descafeinado", precio: 1.4),
    Producto(name: "Batido", precio: 2.8),
    Producto(name: "Té", precio: 1.7),
  ];

  void addProducto(Producto p) {
    listaProductos.add(p);
  }
}
