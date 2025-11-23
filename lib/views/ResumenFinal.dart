import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4_1/models/BarModel.dart';
import 'package:t4_1/viewmodels/BarViewModel.dart';

class ResumenfinalView extends StatelessWidget {
  static const routeName = '/resumenfinal';
  const ResumenfinalView({super.key});
  @override
  Widget build(BuildContext context) {
    final barViewModel = Provider.of<BarViewModel>(context);
    return Column(
      children: [
        Row(children: [Text("Id mesa: "), Text("")]),
        Row(children: [Text("Productor: "), Text("")]),
        Row(children: [Text("Total: "), Text("")]),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Volver"),
        ),
      ],
    );
  }
}
