import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';
import 'package:t4_1/views/CrearPedidoView.dart';
import 'package:t4_1/views/HomeView.dart';
import 'package:t4_1/views/ResumenFinal.dart';
import 'package:t4_1/views/SeleccionProductoView.dart';

/// Inicio de la ejecución de la aplicación.
void main() {
  runApp(const MyApp());
}

/// Clase raíz de la aplicación que configura el estado global y la navegación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Proveedor para que el [BarViewModel] sea accesible desde cualquier pantalla.
    return ChangeNotifierProvider(
      create: (context) => BarViewModel(),
      child: MaterialApp(
        title: "Bar App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),

        /// Ruta inicial de la aplicación.
        initialRoute: HomeWiew.routeName,

        /// Registro de todas las rutas y sus respectivos widgets.
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
