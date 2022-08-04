import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    DateTime selectedDate = DateTime.now();
    DateTime nowDate = DateTime.now();

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
                  border: OutlineInputBorder(),
                  labelText: "Cliente",
                ),
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
                  border: OutlineInputBorder(),
                  labelText: "Livro",
                ),
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
            //data de início -- inserir data do dia
            //data aniversario
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: InputDatePickerFormField(
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
                onDateSubmitted: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
            //prazo de devolução -- adicionar dias as datas
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: InputDatePickerFormField(
                firstDate: DateTime.now(),
                lastDate:
                    DateTime(nowDate.year, nowDate.month, nowDate.day + 7),
                initialDate:
                    DateTime(nowDate.year, nowDate.month, nowDate.day + 7),
                onDateSubmitted: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),

            //botões
            Container(
              width: 100,
              height: 30,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                  child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
