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
      backgroundColor: const Color.fromARGB(255, 249, 239, 223),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 239, 223),

        title: Center(
          child: Card(
            color: const Color.fromARGB(255, 148, 189, 177),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Text(
                "Crea un nuevo pedido",
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 148, 189, 177),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFAC8D),
                          width: 3,
                        ),
                      ),

                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Seleccionproductoview(
                      productosSeleccionadosAnteriores: listaProdutosTemporal,
                    ),
                  ),
                );
                if (!mounted) return;
                if (resultado != null &&
                    resultado is List<Producto> &&
                    mounted) {
                  setState(() {
                    listaProdutosTemporal = resultado;
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  Color(0xFFFFAC8D),
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.brown),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: Icon(Icons.coffee)),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Añadir productos",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Divider(color: Colors.purpleAccent, height: 1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      final mesaIdText = controlador.text;
                      final parsedMesaId = int.tryParse(mesaIdText) ?? -1;

                      if (parsedMesaId <= 0 ||
                          listaProdutosTemporal.isEmpty ||
                          barViewModel
                              .getListaPedidos()
                              .map((e) => e.mesaId)
                              .contains(parsedMesaId)) {
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
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 148, 189, 177),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.brown,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            "Guardar",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Flexible(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xFFFFAC8D),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Color(0xFFFFAC8D),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.brown,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            "Resumen",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
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
