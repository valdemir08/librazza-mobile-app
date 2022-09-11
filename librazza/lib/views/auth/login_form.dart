import 'package:flutter/material.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/views/home/my_home_page.dart';

import '../../services/employe.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _login, _password;
  //late Future<List<Employe>> _employees;
  late List<Employe> _employees = <Employe>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _employees = await EmployeService().getEmployees();
    //List<Employe> list = await _employees;
  }

/*
  Future<List<Employe>> getData() {
    setState(() {
      _employees = EmployeService().getEmployees();
    });
    //return _employees;
    return _employees;
  }*/

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
                controller:
                    TextEditingController(text: "valdemir@librazza.com"),
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                onSaved: (String? value) {
                  _login = value.toString();
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
                controller: TextEditingController(text: "123"),
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
                    bool isLogin = false;
                    for (final employe in _employees) {
                      if (employe.email == _login &&
                          employe.password == _password) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                  title: 'LIBRAZZA', employe: employe)),
                        );
                        isLogin = true;
                        break;
                      }
                    }
                    if (isLogin == false) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Email e/ou senha inválidos")));
                      getData();
                    }
                  }
                },
                child: const Text("Entrar"),
              )),
            ),
          ],
        ));
  }
}
