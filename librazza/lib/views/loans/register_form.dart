import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librazza/models/book.dart';
import 'package:librazza/models/customer.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/models/loan.dart';
import 'package:librazza/services/book.dart';
import 'package:librazza/services/customer.dart';
import 'package:librazza/services/loan.dart';
import 'package:librazza/views/loans/list_all.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.employe}) : super(key: key);

  final Employe employe;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _openDateController = TextEditingController();
  final TextEditingController _closeDateController = TextEditingController();
  DateTime nowDate = DateTime.now();
  late final String _customer, _book, _open_date, _close_date;

  late TextEditingController _customerController = TextEditingController();
  late TextEditingController _bookController = TextEditingController();

  late List<Customer> _customers = <Customer>[];
  late List<Book> _books = <Book>[];

  void getData() async {
    _customers = await CustomerService().getCustomers();
    _books = await BookService().getBooks();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  static String _customerDisplayOption(Customer option) => option.name;
  static String _bookDisplayOption(Book option) => option.title;
  late int _customerId, _bookId;

  @override
  Widget build(BuildContext context) {
    _openDateController.text = DateFormat("dd-MM-yyyy").format(nowDate);
    _closeDateController.text = DateFormat("dd-MM-yyyy")
        .format(DateTime(nowDate.year, nowDate.month, nowDate.day + 7));
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //inputs
            //cliente
            Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Autocomplete<Customer>(
                    displayStringForOption: _customerDisplayOption,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<Customer>.empty();
                      }
                      return _customers.where((Customer option) {
                        return option.name
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    optionsViewBuilder:
                        (context, Function(Customer) onSelected, _customers) {
                      return Material(
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final customer = _customers.elementAt(index);

                            return ListTile(
                              title: Text(customer.name),
                              onTap: () {
                                onSelected(customer);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: _customers.length,
                        ),
                      );
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      _customerController = controller;

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        /*decoration: const InputDecoration(
                          
                          border: OutlineInputBorder(),
                          labelText: "Título",
                        ),*/
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: "Procure um cliente",
                          prefixIcon: Icon(Icons.search),
                        ),
                      );
                    },
                    onSelected: (Customer selection) {
                      _customerId = selection.id;
                    })),
            //livro
            Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Autocomplete<Book>(
                    displayStringForOption: _bookDisplayOption,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<Book>.empty();
                      }
                      return _books.where((Book option) {
                        return option.title
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    optionsViewBuilder:
                        (context, Function(Book) onSelected, _books) {
                      return Material(
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final book = _books.elementAt(index);

                            return ListTile(
                              title: Text(book.title),
                              onTap: () {
                                onSelected(book);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: _books.length,
                        ),
                      );
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      _bookController = controller;

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        /*decoration: const InputDecoration(
                          
                          border: OutlineInputBorder(),
                          labelText: "Título",
                        ),*/
                        decoration: InputDecoration(
                          icon: Icon(Icons.book),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: "Procure um livro",
                          prefixIcon: Icon(Icons.search),
                        ),
                      );
                    },
                    onSelected: (Book selection) {
                      _bookId = selection.id;
                    })),

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
                    _open_date = value.toString();
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
                    _close_date = value.toString();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe a data de abertura";
                    } else {
                      return null;
                    }
                  },
                )),

            //botões
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                  child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    LoanService().createLoan(_open_date, _close_date,
                        "Em aberto", _customerId, widget.employe.id, _bookId);

                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListAll(
                                employe: widget.employe,
                              )),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sucesso!")));
                  }
                },
                child: const Text("Enviar"),
              )),
            ),
          ],
        ));
  }
}
