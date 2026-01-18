import 'package:flutter/material.dart';
import 'package:t4_1/models/Producto.dart';

/// Pantalla que muestra el resumen detallado de un pedido antes de confirmarlo.
class ResumenfinalView extends StatelessWidget {
  static const routeName = '/resumenfinal';
  const ResumenfinalView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Captura los argumentos pasados a través del Navigator.
    final args = ModalRoute.of(context)?.settings.arguments;
    List<Producto> productosLista = [];
    int mesaId = -1;

    /// Extrae y valida la lista de [Producto] y el id de la mesa de los argumentos.
    if (args is Map<String, dynamic>) {
      if (args["productos"] is List) {
        productosLista = List<Producto>.from(args["productos"]);
      } else {
        productosLista = [];
      }
      if (args["mesaId"] is int) {
        mesaId = args["mesaId"];
      } else {
        mesaId = -1;
      }
    }

    /// Calcula el precio total del pedido multiplicando precio por cantidad.
    final double total = productosLista
        .map((e) => e.precio * e.cantidad)
        .fold(0.0, (a, b) => a + b);

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
                "Resumen de pedido",
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Muestra el número de mesa seleccionado.
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Mesa:   ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  Text("$mesaId", style: const TextStyle(color: Colors.brown)),
                ],
              ),
            ),

            /// Cabecera de la lista de productos en el resumen.
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Cantidad",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Producto",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Precio",
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

            /// Lista que genera las tarjetas con los detalles de cada [Producto].
            Flexible(
              child: ListView.builder(
                itemCount: productosLista.length,
                itemBuilder: (context, index) {
                  final producto = productosLista[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                producto.cantidad.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 148, 189, 177),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                producto.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${(producto.cantidad * producto.precio).toStringAsFixed(2)}€",
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

            /// Muestra el importe total del pedido.
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Total: ${total.toStringAsFixed(2)}€",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Botón para cerrar el esta pantalla de resumen y volver atrás.
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFFFFAC8D),
                      ),
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.brown,
                      ),
                    ),
                    child: const Text(
                      "Volver",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
