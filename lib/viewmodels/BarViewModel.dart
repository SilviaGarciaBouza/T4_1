import 'package:flutter/material.dart';
import 'package:t4_1/models/Producto.dart';

import '../models/BarModel.dart';
import '../models/Pedido.dart';

/// Clase que actúa como intermediaria entre las vistas y los modelos.
/// Utiliza [ChangeNotifier] para avisar a la UI de los cambios de los datos.
class BarViewModel extends ChangeNotifier {
  /// Instancia del modelo [BarModel].
  BarModel barModel = BarModel();

  /// Método que obtiene la lista de pedidos.
  List<Pedido> getListaPedidos() {
    return barModel.listaPedidos;
  }

  /// Método que añade un [Pedido] y avisa con [notifyListeners] para que se actualice la vista.
  void addPedido(Pedido p) {
    barModel.addPedido(p);
    notifyListeners();
  }

  /// Método que crea un nuevo [Pedido].
  Pedido crearPedido(int idMesa, List<Producto> listaProductos) {
    return barModel.crearPedido(idMesa, listaProductos);
  }

  /// Método que devuelve una lista de productos.
  List<Producto> getListaProductos() {
    return barModel.listaProductos;
  }

  /// Método que añade un [Producto] y lo notifica a la vista mediante [notifyListeners].
  void addProducto(Producto p) {
    barModel.addProducto(p);
    notifyListeners();
  }
}
