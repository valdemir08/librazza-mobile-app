import 'package:flutter/material.dart';
import 'package:librazza/views/customers/CustomerRegisterView.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({Key? key}) : super(key: key);

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      body: const Center(child: Text("texto")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomerRegisterView()),
        ),
        tooltip: 'Adicionar cliente',
        child: const Icon(Icons.add),
      ),
    );
  }
}
