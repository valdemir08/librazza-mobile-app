import 'package:flutter/material.dart';
import 'package:librazza/models/customer.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/customer.dart';
import 'package:librazza/views/customers/build_customers.dart';
import 'package:librazza/views/customers/register_view.dart';

class ListAll extends StatefulWidget {
  late _ListAllState listAll;

  ListAll({Key? key, required this.employe}) : super(key: key);
  final Employe employe;

  @override
  State<ListAll> createState() => _ListAllState();
}

class _ListAllState extends State<ListAll> {
  @override
  void initState() {
    super.initState();
    widget.listAll = this;
    refreshData();
  }

  late Future<List<Customer>> customers;
  Future<List<Customer>> refreshData() {
    setState(() {
      customers = CustomerService().getCustomers();
    });

    return customers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
            child: FutureBuilder<List<Customer>>(
                future: customers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text("Snapshot Error: ${snapshot.error}"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50)),
                              onPressed: () => refreshData(),
                              child: const Text("Refresh Data"),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.data.toString() == "[]") {
                      return const Text(
                        //snapshot.hasData
                        'Ainda não há Clientes cadastrados',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    } else {
                      return BuildCustomers(
                        customers: snapshot.data,
                        listAllState: this,
                        employe: widget.employe,
                        listAll: widget.listAll,
                      );
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RegisterView(employe: widget.employe)),
        ),
        tooltip: 'Adicionar Cliente',
        child: const Icon(Icons.add),
      ),
    );
  }
}
