import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/models/Producto.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';

class Seleccionproductoview extends StatefulWidget {
  static const routeName = '/seleccionarproductos';
  const Seleccionproductoview({super.key});

  @override
  State<Seleccionproductoview> createState() => _SeleccionproductoviewState();
}

class _SeleccionproductoviewState extends State<Seleccionproductoview> {
  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);
    List<Producto> copiaLista = barViewModel.getListaProductos();
    final List<Producto> productosSeleccionados = [];
    bool isSelect = false;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Selección de productos"))),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Text("Selección")),
              Expanded(flex: 1, child: Text("Nombre")),
              Expanded(flex: 1, child: Text("Precio")),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: barViewModel.getListaProductos().length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: copiaLista[index].esSeleccionado,
                        onChanged: (bool? newValue) {
                          setState(() {
                            copiaLista[index].esSeleccionado =
                                !copiaLista[index].esSeleccionado;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(barViewModel.getListaProductos()[index].name),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        barViewModel
                            .getListaProductos()[index]
                            .precio
                            .toString(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pop(
                      context,
                      copiaLista
                          .where((e) => e.esSeleccionado == true)
                          .toList(),
                    ),
                  },
                  child: Text("Confirmar"),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
