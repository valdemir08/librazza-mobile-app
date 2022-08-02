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

    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //inputs
            //titulo
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Título",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o título";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //edição
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Edição",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe a edição";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //editora
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Editora",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe a editora";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //ano publicação
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ano publicação",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o ano de publicação";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //num paginas
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "N° páginas",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o número de páginas";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //cod barras
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Cód. Barras",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o código de barras";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //genero
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Gênero",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o gênero";
                    //ver a possibilidade de uma tabela genêro
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //quantidade
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Quantidade",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe a quantidade";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            //isbn
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "ISBN",
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Informe o ISBN";
                  } else {
                    return null;
                  }
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
