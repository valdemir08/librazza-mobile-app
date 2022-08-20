import 'package:flutter/material.dart';
import 'package:librazza/models/author.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  Future<Author>? _futureAuthor;

  FutureBuilder<Author> buildFutureBuilder() {
    return FutureBuilder<Author>(
      future: _futureAuthor,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

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
                  _name = value.toString();
                },
                keyboardType: TextInputType.text,
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
                    //_futureAuthor = createAuthor(_name);
                    _futureAuthor = createAuthor("Mario de Andrade");
                    print(_futureAuthor.toString());
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
