import 'package:flutter/material.dart';
import 'package:librazza/views/loans/register_view.dart';

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
        title: const Text("Empréstimos"),
      ),
      body: const Center(child: Text("Listagem de empréstimos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
        ),
        tooltip: 'Adicionar empréstimo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
