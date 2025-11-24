Esta es una aplicación móvil desarrollada en **Flutter** para gestionar pedidos de un bar, implementando la arquitectura **Model-View-ViewModel (MVVM)** y diversas técnicas de navegación.

# Arquitectura y Tecnología

- **Arquitectura:** MVVM (Model, ViewModel, View).
- **Estado:** Gestionado mediante **Provider** (`ChangeNotifier`).
- **Lenguaje:** Dart.
- **UI/UX:** Estilo de alto contraste **Negro y Rojo**.

# Flujo de Navegación Clave

El proyecto cumple con los requisitos de navegación de la tarea:

1.  **Home ➡️ Crear Pedido:** Navegación **Imperativa** (`Navigator.push`).
    - _Home_ espera el resultado (objeto `Pedido`) para añadirlo a la lista.
    - _Home_ usa la validación `if (resultado is Pedido && mounted)`.
2.  **Crear Pedido ➡️ Selección Productos:** Navegación **Imperativa** (`Navigator.push`).
    - _Crear Pedido_ espera el resultado (`List<Producto>`) y usa `setState` con `mounted`.
3.  **Crear Pedido ➡️ Ver Resumen:** Navegación con **Ruta con Nombre** (`Navigator.pushNamed`).

# Puntos Clave del Proyecto

- Implementación correcta del cálculo de `numProductos` (suma de cantidades).
- Validación obligatoria de `mesaId` y `productos` antes de guardar.
- El botón "Guardar Pedido" devuelve el objeto `Pedido` completo usando `Navigator.pop(context, pedidoCompleto)`.

# Uso

1.  Abre la terminal en la carpeta principal.
2.  Ejecuta `flutter pub get`.
3.  Ejecuta `flutter run`.
