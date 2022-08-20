import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _openDateController = TextEditingController();
  TextEditingController _closeDateController = TextEditingController();
  DateTime nowDate = DateTime.now();
  String? _customer, _book, _open_date, _close_date;
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
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: "Cliente",
                ),
                onSaved: (String? value) {
                  _customer = value.toString();
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                  labelText: "Livro",
                ),
                onSaved: (String? value) {
                  _book = value.toString();
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
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
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
