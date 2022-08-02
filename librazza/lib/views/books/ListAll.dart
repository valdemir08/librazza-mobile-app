import 'package:flutter/material.dart';
import 'package:librazza/views/books/RegisterView.dart';

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
        title: Text("Livros"),
      ),
      body: const Center(child: Text("Listagem livros")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
        ),
        tooltip: 'Adicionar livro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
