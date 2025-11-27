import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
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
  int parsedMesaId = -1;

  @override
  void initState() {
    super.initState();
    controlador.addListener(actualizacionMesaId);
  }

  @override
  void dispose() {
    controlador.removeListener(actualizacionMesaId);
    controlador.dispose();
    super.dispose();
  }

  void actualizacionMesaId() {
    final mesaIdText = controlador.text;
    final newMesaId = int.tryParse(mesaIdText) ?? -1;
    if (newMesaId != parsedMesaId) {
      setState(() {
        parsedMesaId = newMesaId;
      });
    }
  }

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
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 32.0,
                right: 32.0,
              ),
              child: const Text(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: controlador,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
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

            Card(
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mesa: ${parsedMesaId > 0 ? parsedMesaId : ' sin mesa'}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Productos:",
                     
                    ),
                    SizedBox(
                      height: listaProdutosTemporal.length * 40.0,
                      child: listaProdutosTemporal.isEmpty
                          ? const Center(
                              child: Text(
                                "No hay productos seleccionados.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: listaProdutosTemporal.length,
                              itemBuilder: (context, index) {
                                final producto = listaProdutosTemporal[index];
                                return Row(
                                  children: [
                                  
                                   Text(
                                      "${producto.cantidad} x ${producto.name} "),
                                  Text(
                                      "${(producto.precio * producto.cantidad).toStringAsFixed(2)} €"),
                   ] );
                              },
                            ),
                    ),
                    const Divider(),
                    Text(
                      "Total: ${listaProdutosTemporal.map((e) => e.precio * e.cantidad).fold(0.0, (a, b) => a + b).toStringAsFixed(2)} €",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

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
                  if (resultado != null && resultado is List<Producto>) {
                    setState(() {
                      listaProdutosTemporal = resultado;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFFFFAC8D)),
                  foregroundColor:
                      WidgetStateProperty.all<Color>(Colors.brown),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.coffee),
                    SizedBox(width: 8),
                    Text(
                      "Añadir productos",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Divider(color: Colors.purpleAccent, height: 1),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      if (parsedMesaId <= 0 ||
                          listaProdutosTemporal.isEmpty ||
                          barViewModel
                              .getListaPedidos()
                              .map((e) => e.mesaId)
                              .contains(parsedMesaId)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Introduce un id de mesa y  productos válidos y que la mesa no  esté ocupada",
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
                     // barViewModel.addPedido(pedidoCompleto);
                      Navigator.pop(context, pedidoCompleto);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color.fromARGB(255, 148, 189, 177),
                      ),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.brown),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Guardar",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

               
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(const Color(0xFFFFAC8D)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Cancelar",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

              
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
                      backgroundColor:
                          WidgetStateProperty.all<Color>(const Color(0xFFFFAC8D)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.brown),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Resumen",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
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