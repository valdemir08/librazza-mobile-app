import 'package:flutter/material.dart';
import 'package:librazza/models/author.dart';
import 'package:librazza/views/authors/ListAll.dart';
import 'package:librazza/services/api_service_author.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  Future<Author>? _futureAuthor;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //inputs
            //nome
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: "Nome",
                ),
                onSaved: (String? value) {
                  name = value.toString();
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o nome";
                  } else {
                    return null;
                  }
                },
              ),
            ),

            //botões
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _futureAuthor = ApiServiceAuthor().createAuthor(name);

                    Navigator.pop(context, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListAll()),
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
