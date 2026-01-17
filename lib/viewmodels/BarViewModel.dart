import 'package:flutter/material.dart';
import 'package:t4_1/models/Producto.dart';

import '../models/BarModel.dart';
import '../models/Pedido.dart';

/// Intermediario entre la Vista y el Modelo.
/// Utiliza [ChangeNotifier] para notificar a la UI cuando los datos cambian.
class BarViewModel extends ChangeNotifier {
  /// Instancia del modelo de datos.
  BarModel barModel = BarModel();

  /// Obtiene los pedidos actuales para mostrarlos en la Home.
  List<Pedido> getListaPedidos() {
    return barModel.listaPedidos;
  }

  /// Agrega un pedido y dispara [notifyListeners] para refrescar la lista en pantalla.

  void addPedido(Pedido p) {
    barModel.addPedido(p);
    notifyListeners();
  }

  /// Expone la funcionalidad de creación de pedidos del modelo.
  Pedido crearPedido(int idMesa, List<Producto> listaProductos) {
    return barModel.crearPedido(idMesa, listaProductos);
  }

  List<Producto> getListaProductos() {
    return barModel.listaProductos;
  }

  void addProducto(Producto p) {
    barModel.addProducto(p);
    notifyListeners();
  }
}
