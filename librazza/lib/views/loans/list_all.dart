import 'package:flutter/material.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/models/loan.dart';
import 'package:librazza/services/loan.dart';
import 'package:librazza/views/loans/build_loans.dart';
import 'package:librazza/views/loans/register_view.dart';

class ListAll extends StatefulWidget {
  const ListAll({Key? key, required this.employe}) : super(key: key);
  final Employe employe;

  @override
  State<ListAll> createState() => _ListAllState();
}

class _ListAllState extends State<ListAll> {
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  late Future<List<Loan>> loans;
  Future<List<Loan>> refreshData() {
    setState(() {
      loans = LoanService().getLoans();
    });

    return loans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empréstimos"),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
            child: FutureBuilder<List<Loan>>(
                future: loans,
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
                          'Ainda não há Empréstimos cadastrados');
                    } else {
                      return BuildLoans(
                        loans: snapshot.data,
                        listAllState: this,
                        employe: widget.employe,
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
              builder: (context) => RegisterView(
                    employe: widget.employe,
                  )),
        ),
        tooltip: 'Adicionar empréstimo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
