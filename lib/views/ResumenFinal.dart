import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';

class ResumenfinalView extends StatelessWidget {
  static const routeName = '/resumenfinal';
  const ResumenfinalView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    List<Producto> productosLista = [];
    int mesaId = -1;
    if (args is Map<String, dynamic>) {
      if (args["productos"] is List) {
        productosLista = List<Producto>.from(args["productos"]);
      }
      if (args["mesaId"] is int) {
        mesaId = args["mesaId"];
      }
    }
    final double total = productosLista
        .map((e) => e.precio * e.cantidad)
        .fold(0.0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Resumen de pedido", style: TextStyle(color: Colors.red)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListView(
              children: [
                Row(children: [Text("Id mesa: "), Text("$mesaId")]),
                Row(
                  children: [
                    for (var producto in productosLista)
                      Flexible(
                        child: Text(
                          "${producto.cantidad} ${producto.name}: ${producto.precio}€  = ${producto.cantidad * producto.precio}",
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Text("Total: "),
                    Text("${total.toStringAsFixed(2)}  "),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Volver"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
