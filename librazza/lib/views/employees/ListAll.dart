import 'package:flutter/material.dart';
import 'package:librazza/views/employees/RegisterView.dart';

class ListAll extends StatefulWidget {
  const ListAll({Key? key}) : super(key: key);

  @override
  State<ListAll> createState() => _ListAllState();
}

class _ListAllState extends State<ListAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Funcionários"),
      ),
      body: const Center(child: Text("Listagem funcionários")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
        ),
        tooltip: 'Adicionar funcionário',
        child: const Icon(Icons.add),
      ),
    );
  }
}
