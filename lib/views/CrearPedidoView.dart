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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Crea un nuevo pedido",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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
              ],
            ),
          ),

          Flexible(
            child: ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Seleccionproductoview(
                      productosSeleccionadosAnteriores: listaProdutosTemporal,
                    ),
                  ),
                );if (!mounted) return;
                if (resultado != null &&
                    resultado is List<Producto> &&
                    mounted) {
                  setState(() {
                    listaProdutosTemporal = resultado;
                  });
                }
              },
              child: Text("Añadir productos"),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      final mesaIdText = controlador.text;
                      final parsedMesaId = int.tryParse(mesaIdText) ?? -1;

                      if (parsedMesaId <= 0 || listaProdutosTemporal.isEmpty || barViewModel.getListaPedidos().map((e)=> e.mesaId).contains(parsedMesaId)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Introduce un id de mesa y productos válidos",
                            ),
                          ),
                        );
                        return;
                      }

                      final double totalCalculado = listaProdutosTemporal
                          .map((e) => e.precio * e.cantidad)
                          .fold(0.0, (a, b) => a + b);

                      final Pedido pedidoCompleto = Pedido(
                        mesaId: parsedMesaId,
                        numProductos: listaProdutosTemporal.fold(
                          0,
                          (sum, p) => sum + p.cantidad,
                        ),

                        totalEuros: totalCalculado,
                      );

                      Navigator.pop(context, pedidoCompleto);
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
                      final currentMesaId =
                          int.tryParse(controlador.text) ?? -1;

                      if (currentMesaId <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Introduce un id de mesa válido"),
                          ),
                        );
                        return;
                      }
                      if (listaProdutosTemporal.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Añadir algún producto."),
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
          ),
        ],
      ),
    );
  }
}
