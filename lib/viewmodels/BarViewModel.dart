import 'package:flutter/material.dart';
import 'package:t4_1/models/Producto.dart';

import '../models/BarModel.dart';
import '../models/Pedido.dart';

class BarViewModel extends ChangeNotifier {
  BarModel barModel = BarModel();
  List<Pedido> getListaPedidos() {
    return barModel.listaPedidos;
  }

  void addPedido(Pedido p) {
    barModel.addPedido(p);
    notifyListeners();
  }

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
