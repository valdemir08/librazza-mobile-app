import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:librazza/services/book.dart';
import 'package:librazza/views/books/list_all.dart';
import 'package:librazza/widgets/mask_formatter.dart' as mask;

import '../../models/author.dart';
import '../../models/employe.dart';
import '../../services/author.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.employe}) : super(key: key);
  final Employe employe;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  late String _title,
      _edition,
      _publishing_company,
      _year_of_publication,
      _number_of_pages,
      _code_bar,
      _gender,
      _isbn;

  late int _amount, _authorId;
  late TextEditingController _authorController = TextEditingController();

  late List<Author> _authors = <Author>[];

  static String _displayStringForOption(Author option) => option.name!;

  //Future<List<Author>> authors;
  void getData() async {
    _authors = await AuthorService().getAuthors();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    //_authorController.dispose();
    super.dispose();
  }

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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
                    return "Informe a edição";
                  } else {
                    return null;
                  }
                },
              ),
            ),

            Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Autocomplete<Author>(
                    displayStringForOption: _displayStringForOption,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<Author>.empty();
                      }
                      return _authors.where((Author option) {
                        return option
                            .toString()
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    optionsViewBuilder:
                        (context, Function(Author) onSelected, _authors) {
                      return Material(
                        elevation: 4,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final author = _authors.elementAt(index);

                            return ListTile(
                              title: Text(author.name!),
                              onTap: () {
                                onSelected(author);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: _authors.length,
                        ),
                      );
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                      _authorController = controller;

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        /*decoration: const InputDecoration(
                          
                          border: OutlineInputBorder(),
                          labelText: "Título",
                        ),*/
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: "Procure um autor",
                          prefixIcon: Icon(Icons.search),
                        ),
                      );
                    },
                    onSelected: (Author selection) {
                      _authorId = selection.id;
                    })),
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
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
                  _amount = int.parse(value!);
                },
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
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
                  if (value!.isEmpty) {
                    return "Informe o ISBN";
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

                    BookService().createBook(
                        _title, //
                        _edition,
                        _publishing_company,
                        _year_of_publication,
                        _number_of_pages,
                        _code_bar,
                        _gender,
                        _amount,
                        widget.employe.companyId,
                        _isbn,
                        _authorId);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sucesso!")));

                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListAll(
                                employe: widget.employe,
                              )),
                    );
                  }
                },
                child: const Text("Enviar"),
              )),
            ),
          ],
        ));
  }
}
