import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/HomeView.dart';
import 'package:t4_1/views/ResumenFinal.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/views/SeleccionProductoView.dart';

class Crearpedidoview extends StatefulWidget {
  static const routeName = '/crearpedido';
  const Crearpedidoview({super.key});

  @override
  State<Crearpedidoview> createState() => _CrearpedidoviewState();
}

class _CrearpedidoviewState extends State<Crearpedidoview> {
  final TextEditingController controlador = TextEditingController();
  List<Producto> listaProdutosTemporal = [];
  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Crea un nuevo pedido"))),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: controlador,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introduce el Nº de Mesa',
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.pushNamed(
                  context,
                  Seleccionproductoview.routeName,
                );
                if (resultado != null && resultado is List<Producto>) {
                  setState(() {
                    listaProdutosTemporal = resultado;
                  });

                  print('Lista recibida: ${resultado.toString()}');
                }
              },
              child: Text("Añadir productos"),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    final mesaIdText = controlador.text;
                    final parsedMesaId = int.tryParse(mesaIdText) ?? -1;

                    if (parsedMesaId <= 0 || listaProdutosTemporal.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Error: Introduce un id de mesa válido y añade productos.",
                          ),
                        ),
                      );
                      return;
                    }

                    barViewModel.addPedido(
                      Pedido(
                        mesaId: parsedMesaId,
                        numProductos: listaProdutosTemporal.length,
                        totalEuros: listaProdutosTemporal
                            .map((e) => e.precio)
                            .fold(0.0, (a, b) => a + b),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  child: Text("Guardar pedido"),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    final currentMesaId = int.tryParse(controlador.text) ?? -1;

                    if (currentMesaId <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Error: Introduce un id de mesa válido para ver el resumen.",
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pushNamed(
                      context,
                      ResumenfinalView.routeName,
                      arguments: {
                        "productos": listaProdutosTemporal,
                        "mesaId": currentMesaId,
                      },
                    );
                  },
                  child: Text("Ver resumen"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
