import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //inputs
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o valor";
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
