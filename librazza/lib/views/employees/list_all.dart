import 'package:flutter/material.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/employe.dart';
import 'package:librazza/views/employees/build_employees.dart';
import 'package:librazza/views/employees/register_view.dart';

class ListAll extends StatefulWidget {
  const ListAll({Key? key}) : super(key: key);

  @override
  State<ListAll> createState() => _ListAllState();
}

class _ListAllState extends State<ListAll> {
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  late Future<List<Employe>> employees;
  Future<List<Employe>> refreshData() {
    setState(() {
      employees = EmployeService().getEmployees();
    });

    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Funcionários"),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
            child: FutureBuilder<List<Employe>>(
                future: employees,
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
                      return const Text(//snapshot.hasData
                          'Ainda não há Funcionários cadastrados');
                    } else {
                      return BuildEmployees(
                          employees: snapshot.data, listAllState: this);
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
          MaterialPageRoute(builder: (context) => const RegisterView()),
        ),
        tooltip: 'Adicionar Funcionário',
        child: const Icon(Icons.add),
      ),
    );
  }
}
