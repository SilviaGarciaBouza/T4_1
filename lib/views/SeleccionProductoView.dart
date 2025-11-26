import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';

class Seleccionproductoview extends StatefulWidget {
  static const routeName = '/seleccionarproductos';
  const Seleccionproductoview({
    super.key,
    this.productosSeleccionadosAnteriores = const [],
  });
  final List<Producto> productosSeleccionadosAnteriores;
  @override
  State<Seleccionproductoview> createState() => _SeleccionproductoviewState();
}

class _SeleccionproductoviewState extends State<Seleccionproductoview> {
  bool initialized = false;

  List<int> numeros = List<int>.generate(21, (i) => i);
  late List<Producto> copiaLista;

  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);

    if (!initialized) {
      final listaBase = barViewModel.getListaProductos();

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
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                left: 32.0,
                right: 32.0,
              ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Cantidad",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Producto",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Pecio",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Divider(color: Colors.purpleAccent, height: 1),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: copiaLista.length,
                itemBuilder: (context, index) {
                  var producto = copiaLista[index];
                  return Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: DropdownButton<int>(
                            value: producto.cantidad,

                            onChanged: (int? nuevoValor) {
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
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(producto.name),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("${producto.precio.toString()}€"),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              "Confirmar",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
