import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/ResumenFinal.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/views/SeleccionProductoView.dart';

/// Pantalla para crear un nuevo [Pedido] seleccionando mesa y productos.
class Crearpedidoview extends StatefulWidget {
  static const routeName = '/crearpedido';
  const Crearpedidoview({super.key});

  @override
  State<Crearpedidoview> createState() => _CrearpedidoviewState();
}

class _CrearpedidoviewState extends State<Crearpedidoview> {
  /// Controlador para leer el número de mesa del teclado.
  final TextEditingController controlador = TextEditingController();

  /// Lista temporal para ir guardando los productos elegidos.
  List<Producto> listaProdutosTemporal = [];

  /// Variable para guardar el número de la mesa.
  int parsedMesaId = -1;

  @override
  void initState() {
    super.initState();

    /// Escucha lo que se escribe para actualizar el id de la mesa.
    controlador.addListener(actualizacionMesaId);
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  /// Convierte el texto escrito a un número entero que indica el número de la mesa.
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Campo de texto para introducir el número de mesa.
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: controlador,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Introduce el Nº de Mesa',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 148, 189, 177),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            /// Tarjeta que muestra el resumen actual de la mesa y el total.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mesa: ${parsedMesaId > 0 ? parsedMesaId : ' sin mesa'}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text("Productos:"),
                    SizedBox(
                      height: listaProdutosTemporal.length * 22.0,
                      child: listaProdutosTemporal.isEmpty
                          ? const Center(
                              child: Text(
                                "No hay productos seleccionados.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: listaProdutosTemporal.length,
                              itemBuilder: (context, index) {
                                final producto = listaProdutosTemporal[index];
                                return Text(
                                  "${producto.cantidad} x ${producto.name} - ${(producto.precio * producto.cantidad).toStringAsFixed(2)} €",
                                );
                              },
                            ),
                    ),
                    const Divider(),
                    Text(
                      "Total: ${listaProdutosTemporal.map((e) => e.precio * e.cantidad).fold(0.0, (a, b) => a + b).toStringAsFixed(2)} €",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Botón para ir a la pantalla de elegir productos.
            ElevatedButton(
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
              child: const Text("Añadir productos"),
            ),

            const SizedBox(height: 16),

            /// Botón para confirmar y guardar el pedido final.
            ElevatedButton(
              onPressed: () {
                if (parsedMesaId <= 0 ||
                    listaProdutosTemporal.isEmpty ||
                    barViewModel
                        .getListaPedidos()
                        .map((e) => e.mesaId)
                        .contains(parsedMesaId)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Datos inválidos o mesa ocupada"),
                    ),
                  );
                  return;
                }
                final pedidoCompleto = Pedido(
                  mesaId: parsedMesaId,
                  numProductos: listaProdutosTemporal.fold(
                    0,
                    (sum, p) => sum + p.cantidad,
                  ),
                  totalEuros: listaProdutosTemporal
                      .map((e) => e.precio * e.cantidad)
                      .fold(0.0, (a, b) => a + b),
                );
                Navigator.pop(context, pedidoCompleto);
              },
              child: const Text("Guardar pedido"),
            ),

            /// Botón para ver el resumen del pedido.
            ElevatedButton(
              onPressed: () {
                if (parsedMesaId > 0 && listaProdutosTemporal.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    ResumenfinalView.routeName,
                    arguments: {
                      "productos": listaProdutosTemporal,
                      "mesaId": parsedMesaId,
                    },
                  );
                }
              },
              child: const Text("Ver resumen"),
            ),
          ],
        ),
      ),
    );
  }
}
