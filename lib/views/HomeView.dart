import 'package:flutter/material.dart';
import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/CrearPedidoView.dart';
import 'package:provider/provider.dart';

/// Pantalla principal que muestra el listado de todas las mesas con pedidos activos.
class HomeWiew extends StatefulWidget {
  static const routeName = '/';
  const HomeWiew({super.key});

  @override
  State<HomeWiew> createState() => _HomeWiewState();
}

class _HomeWiewState extends State<HomeWiew> {
  @override
  Widget build(BuildContext context) {
    /// Obtenemos el [barViewModel] para acceder a la lista de pedidos.
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
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32.0,
              ),
              child: const Text(
                "Lista de pedidos",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Cabecera de la tabla con los títulos de las columnas.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Mesa",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Nº productos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Total",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.purpleAccent, height: 1),
          ),

          /// Lista que muestra cada [Pedido] del [BarViewModel].
          Expanded(
            child: ListView.builder(
              itemCount: barViewModel.getListaPedidos().length,
              itemBuilder: (context, index) {
                final pedido = barViewModel.getListaPedidos()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 16.0,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              pedido.mesaId.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 148, 189, 177),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              pedido.numProductos.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${pedido.totalEuros.toStringAsFixed(2)}€",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.brown),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  /// Navega a [Crearpedidoview] y espera recibir un objeto [Pedido].
                  final resultado = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Crearpedidoview(),
                    ),
                  );

                  if (!mounted) return;

                  /// Si el resultado es un [Pedido] válido, se añade al modelo y se actualiza la vista.
                  if (resultado != null && resultado is Pedido) {
                    setState(() {
                      barViewModel.addPedido(resultado);
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFFFFAC8D),
                  ),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.brown),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.coffee),
                    SizedBox(width: 8),
                    Text(
                      "Nuevo pedido",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
