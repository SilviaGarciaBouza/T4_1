import 'package:flutter/material.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/CrearPedidoView.dart';
import 'package:provider/provider.dart';

class HomeWiew extends StatelessWidget {
  static const routeName = '/';
  const HomeWiew({super.key});
  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Lista de pedidos"))),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Text("Nº mesa")),
              Expanded(flex: 1, child: Text("Nº productos")),
              Expanded(flex: 1, child: Text("Total")),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: barViewModel.getListaPedidos().length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        barViewModel.getListaPedidos()[index].mesaId.toString(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        barViewModel
                            .getListaPedidos()[index]
                            .numProductos
                            .toString(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        barViewModel
                            .getListaPedidos()[index]
                            .totalEuros
                            .toString(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Crearpedidoview.routeName),
              child: Text("Añadir pedido"),
            ),
          ),
        ],
      ),
    );
  }
}
