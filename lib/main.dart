import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/CrearPedidoView.dart';
import 'package:t4_1/views/HomeView.dart';
import 'package:t4_1/views/ResumenFinal.dart';
import 'package:t4_1/views/SeleccionProductoView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BarViewModel(),
      child: MaterialApp(
        title: "Bar App",
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: HomeWiew.routeName,
        routes: {
          HomeWiew.routeName: (_) => HomeWiew(),
          Crearpedidoview.routeName: (_) => Crearpedidoview(),
          ResumenfinalView.routeName: (_) => ResumenfinalView(),
          Seleccionproductoview.routeName: (_) => Seleccionproductoview(),
        },
      ),
    );
  }
}
