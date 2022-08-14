import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:librazza/widgets/MaskFormatter.dart' as mask;

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String? _title,
      _edition,
      _publishing_company,
      _year_of_publication,
      _number_of_pages,
      _code_bar,
      _gender,
      _amount,
      _isbn;

  @override
  Widget build(BuildContext context) {
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
                  icon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                  labelText: "Título",
                ),
                onSaved: (String? value) {
                  _title = value.toString();
                },
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
                  icon: Text(
                    "Xª",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "Edição",
                ),
                onSaved: (String? value) {
                  _edition = value.toString();
                },
                keyboardType: TextInputType.number,
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
                  icon: Icon(Icons.apartment),
                  border: OutlineInputBorder(),
                  labelText: "Editora",
                ),
                onSaved: (String? value) {
                  _publishing_company = value.toString();
                },
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
                inputFormatters: [mask.yearFormater],
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  labelText: "Ano publicação",
                ),
                onSaved: (String? value) {
                  _year_of_publication = value.toString();
                },
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
                  icon: Icon(Icons.pin_outlined),
                  border: OutlineInputBorder(),
                  labelText: "N° páginas",
                ),
                onSaved: (String? value) {
                  _number_of_pages = value.toString();
                },
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
                  icon: Icon(CupertinoIcons.barcode),
                  border: OutlineInputBorder(),
                  labelText: "Cód. Barras",
                ),
                onSaved: (String? value) {
                  _code_bar = value.toString();
                },
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
                  icon: Icon(Icons.favorite),
                  border: OutlineInputBorder(),
                  labelText: "Gênero",
                ),
                onSaved: (String? value) {
                  _gender = value.toString();
                },
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
                  icon: Icon(Icons.pin_outlined),
                  border: OutlineInputBorder(),
                  labelText: "Quantidade de livros",
                ),
                onSaved: (String? value) {
                  _amount = value.toString();
                },
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
                  icon: Text(
                    "ISBN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  border: OutlineInputBorder(),
                  labelText: "ISBN",
                ),
                onSaved: (String? value) {
                  _isbn = value.toString();
                },
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
