import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librazza/models/author.dart';
import 'package:librazza/models/loan.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/author.dart';
import 'package:librazza/services/loan.dart';
import 'package:librazza/views/books/list_all.dart';
import 'package:librazza/widgets/mask_formatter.dart' as mask;

class EditForm extends StatefulWidget {
  final Loan loan;
  final Employe employe;

  const EditForm({Key? key, required this.loan, required this.employe})
      : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  late final Loan loan = widget.loan;
  final _formKey = GlobalKey<FormState>();
  static String _displayStringForOption(Author option) => option.name!;

  late final TextEditingController _bookIdController =
      TextEditingController(text: loan.bookId.toString());

  late final TextEditingController _openDateController =
      TextEditingController(text: loan.openDate);

  late final TextEditingController _closeDateController =
      TextEditingController(text: loan.closeDate);

  late final TextEditingController _statusController =
      TextEditingController(text: loan.status);

  late final TextEditingController _customerIdController =
      TextEditingController(
          text: loan.customerId
              .toString()); //verificar como esta sendo passada essa data

  late final TextEditingController _employeIdController =
      TextEditingController(text: loan.employeId.toString());

  //late TextEditingController _authorIdController = TextEditingController(text: book.);

  late List<Author> _authors = <Author>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Future<List<Author>> authors;
  void getData() async {
    _authors = await AuthorService().getAuthors();
  }

  late TextEditingController _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Editar Autor"),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //title
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _customerIdController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: "Cliente",
                      ),
                      onSaved: (String? value) {
                        _customerIdController.text = value.toString();
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "selecione o cliente";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  //livro
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _bookIdController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: "Livro",
                      ),
                      onSaved: (String? value) {
                        _bookIdController.text = value.toString();
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "selecione o livro";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  //data de abertura do empréstimo
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey),
                        controller: _openDateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Data de abertura",
                          icon: Icon(Icons.calendar_month_outlined),
                        ),
                        readOnly: true,
                        onSaved: (String? value) {
                          _openDateController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe a data de abertura";
                          } else {
                            return null;
                          }
                        },
                      )),

                  //data de encerramento do empréstimo -- criar função que calcula caso implemente os selos
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey),
                        controller: _closeDateController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data de encerramento",
                            icon: Icon(Icons.calendar_month_outlined)),
                        readOnly: true,
                        onSaved: (String? value) {
                          _closeDateController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe a data de abertura";
                          } else {
                            return null;
                          }
                        },
                      )),

                  //botoes
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          LoanService().updateLoan(
                            loan.id,
                            _openDateController.text, //
                            _closeDateController.text,
                            _statusController.text,
                            int.parse(_customerIdController.text),
                            int.parse(_employeIdController.text),
                            int.parse(_bookIdController.text),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Sucesso!")));

                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListAll(
                                      employe: widget.employe,
                                    )),
                          );
                        }
                      },
                      child: const Text("Enviar"),
                    )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
