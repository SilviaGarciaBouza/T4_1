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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Selección deproductos",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: Center(child: Text("Cantidad"))),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Nombre"),
                ),
              ),
              Expanded(flex: 2, child: Text("Precio")),
            ],
          ),
          const Divider(),
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
                    Expanded(flex: 2, child: Text(producto.precio.toString())),
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
                    child: const Text("Confirmar"),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
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
