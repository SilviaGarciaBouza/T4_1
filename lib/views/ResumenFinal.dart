import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';

class ResumenfinalView extends StatelessWidget {
  static const routeName = '/resumenfinal';
  const ResumenfinalView({super.key});
  @override
  Widget build(BuildContext context) {
    //final barViewModel = Provider.of<BarViewModel>(context);
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
        .map((e) => e.precio)
        .fold(0.0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Resumen de Pedido"))),
      body: ListView(
        children: [
          Row(children: [Text("Id mesa: "), Text("${mesaId.toString}")]),
          Row(
            children: [Text("Productor: "), Text("${productosLista.length}")],
          ),
          Row(children: [Text("Total: "), Text("$total")]),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Volver"),
          ),
        ],
      ),
    );
  }
}
