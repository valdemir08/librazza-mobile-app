import 'package:flutter/material.dart';
import 'package:librazza/views/home/my_home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _password;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //inputs
            //email
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                onSaved: (String? value) {
                  _name = value.toString();
                },
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Informe o email";
                  } else {
                    return null;
                  }
                },
              ),
            ),

            //senha
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  labelText: "Senha",
                ),
                onSaved: (String? value) {
                  _password = value.toString();
                },
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  //value.trim().isEmpty
                  if (value!.isEmpty) {
                    return "Informe a senha";
                  } else {
                    return null;
                  }
                },
              ),
            ),

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'LIBRAZZA')),
                    );
                  }
                },
                child: const Text("Entrar"),
              )),
            ),
          ],
        ));
  }
}
