import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:librazza/models/author.dart';
import 'package:librazza/services/api_service_author.dart';
import 'package:librazza/views/authors/ListAll.dart';

class EditForm extends StatelessWidget {
  EditForm({Key? key, required this.author}) : super(key: key);

  final Author author;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController =
      TextEditingController(text: author.name);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Editar Autor"),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: "Nome",
                      ),
                      onSaved: (String? value) {
                        _nameController.text = value.toString();
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          ApiServiceAuthor()
                              .updateAuthor(author.id, _nameController.text);

                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListAll()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Sucesso!")));
                        }
                      },
                      child: const Text("Enviar"),
                    )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
