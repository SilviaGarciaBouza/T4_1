import 'package:flutter/material.dart';
import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/CrearPedidoView.dart';
import 'package:provider/provider.dart';

class HomeWiew extends StatefulWidget {
  static const routeName = '/';
  const HomeWiew({super.key});

  @override
  State<HomeWiew> createState() => _HomeWiewState();
}

class _HomeWiewState extends State<HomeWiew> {
  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Lista de pedidos", style: TextStyle(color: Colors.red)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text("Nº mesa")),
                Expanded(flex: 1, child: Text("Nº productos")),
                Expanded(flex: 1, child: Text("Total")),
              ],
            ),
          ),
          Divider(color: Colors.red, height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: barViewModel.getListaPedidos().length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          barViewModel
                              .getListaPedidos()[index]
                              .mesaId
                              .toString(),
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
                              .toStringAsFixed(2)
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Crearpedidoview(),
                  ),
                );

                if (resultado != null && resultado is Pedido && mounted) {
                  barViewModel.addPedido(resultado);
                }
              },
              child: Text("Añadir pedido"),
            ),
          ),
        ],
      ),
    );
  }
}
