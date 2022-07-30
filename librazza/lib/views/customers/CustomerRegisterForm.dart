import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomerRegisterForm extends StatefulWidget {
  const CustomerRegisterForm({Key? key}) : super(key: key);

  @override
  State<CustomerRegisterForm> createState() => _CustomerRegisterFormState();
}

class _CustomerRegisterFormState extends State<CustomerRegisterForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                  labelText: "Nome",
                ),
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
            //cpf
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Cpf",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o cpf";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //telefone
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Telefone",
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o telefone";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //email
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o email";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //botões
            Container(
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
