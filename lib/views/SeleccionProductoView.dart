import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';

/// Pantalla para elegir las cantidades de cada [Producto] para el pedido.
class Seleccionproductoview extends StatefulWidget {
  static const routeName = '/seleccionarproductos';

  const Seleccionproductoview({
    super.key,
    this.productosSeleccionadosAnteriores = const [],
  });

  /// Lista de productos que ya tenían una cantidad seleccionada anteriormente.
  final List<Producto> productosSeleccionadosAnteriores;

  @override
  State<Seleccionproductoview> createState() => _SeleccionproductoviewState();
}

class _SeleccionproductoviewState extends State<Seleccionproductoview> {
  /// Variable para controlar que la lista se inicialice solo una vez.
  bool initialized = false;

  /// Lista de números del 0 al 20 para llenar los desplegables de cantidad.
  List<int> numeros = List<int>.generate(21, (i) => i);

  /// Copia local de los productos para trabajar sin modificar el catálogo global.
  late List<Producto> copiaLista;

  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);

    /// Inicializa la copia de la lista y recupera las cantidades previas si existen.
    if (!initialized) {
      final mapaSeleccionados = {
        for (var p in widget.productosSeleccionadosAnteriores)
          p.name: p.cantidad,
      };

      copiaLista = barViewModel.getListaProductos().map((p) {
        int cantidadAnterior = mapaSeleccionados[p.name] ?? 0;
        return Producto(
          name: p.name,
          precio: p.precio,
          esSeleccionado: p.esSeleccionado,
          cantidad: cantidadAnterior,
        );
      }).toList();
      initialized = true;
    }

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
                "Selección productos",
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
            /// Cabecera con los títulos de las columnas de la lista.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: const [
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

            /// Lista con desplegables para elegir la cantidad de cada [Producto].
            Expanded(
              child: ListView.builder(
                itemCount: copiaLista.length,
                itemBuilder: (context, index) {
                  var producto = copiaLista[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: DropdownButton<int>(
                              value: producto.cantidad,
                              onChanged: (int? nuevoValor) {
                                /// Actualiza la cantidad del producto en la copia local.
                                setState(() {
                                  copiaLista[index].cantidad = nuevoValor ?? 0;
                                });
                              },
                              items: numeros.map<DropdownMenuItem<int>>((
                                int numero,
                              ) {
                                return DropdownMenuItem<int>(
                                  value: numero,
                                  child: Text(numero.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            producto.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${producto.precio.toString()}€",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Botón para confirmar la selección y devolver solo productos con cantidad.
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.pop(
                          context,
                          copiaLista.where((e) => e.cantidad > 0).toList(),
                        ),
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 148, 189, 177),
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.brown,
                        ),
                      ),
                      child: const Text(
                        "Confirmar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// Botón para cerrar la pantalla sin guardar cambios.
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFFFFAC8D),
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
