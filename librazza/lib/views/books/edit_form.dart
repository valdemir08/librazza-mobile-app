import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librazza/models/author.dart';
import 'package:librazza/models/book.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/author.dart';
import 'package:librazza/services/book.dart';
import 'package:librazza/views/books/list_all.dart';
import 'package:intl/intl.dart';
import 'package:librazza/widgets/mask_formatter.dart' as mask;

class EditForm extends StatefulWidget {
  final Book book;
  final Employe employe;

  const EditForm({Key? key, required this.book, required this.employe})
      : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  late final Book book = widget.book;
  final _formKey = GlobalKey<FormState>();
  static String _displayStringForOption(Author option) => option.name!;

  late final TextEditingController _titleController =
      TextEditingController(text: book.title);

  late final TextEditingController _editionController =
      TextEditingController(text: book.edition);

  late final TextEditingController _publishingCompanyController =
      TextEditingController(text: book.publishingCompany);

  late final TextEditingController _yearPublicationController =
      TextEditingController(text: book.yearPublication);

  late final TextEditingController _numPagesController =
      TextEditingController(text: book.numPages);

  late final TextEditingController _barcodeController = TextEditingController(
      text: book.barcode); //verificar como esta sendo passada essa data

  late final TextEditingController _genderController =
      TextEditingController(text: book.gender);

  late final TextEditingController _amountController =
      TextEditingController(text: book.amount.toString());

  late final TextEditingController _isbnController =
      TextEditingController(text: book.isbn);

  //late TextEditingController _authorIdController = TextEditingController(text: book.);

  late List<Author> _authors = <Author>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Future<List<Author>> authors;
  void getData() async {
    _authors = await AuthorService().getAuthors();
  }

  late TextEditingController _authorController = TextEditingController();

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
                  //title
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        border: OutlineInputBorder(),
                        labelText: "Título",
                      ),
                      onSaved: (String? value) {
                        _titleController.text = value.toString();
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
                      controller: _editionController,
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
                        _editionController.text = value.toString();
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

/*
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Autocomplete<Author>(
                          displayStringForOption: _displayStringForOption,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<Author>.empty();
                            }
                            return _authors.where((Author option) {
                              return option.toString().toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
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
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
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
                          })),*/

                  //editora
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _publishingCompanyController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.apartment),
                        border: OutlineInputBorder(),
                        labelText: "Editora",
                      ),
                      onSaved: (String? value) {
                        _publishingCompanyController.text = value.toString();
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
                      controller: _yearPublicationController,
                      inputFormatters: [mask.yearFormater],
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                        labelText: "Ano publicação",
                      ),
                      onSaved: (String? value) {
                        _yearPublicationController.text = value.toString();
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
                      controller: _numPagesController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.pin_outlined),
                        border: OutlineInputBorder(),
                        labelText: "N° páginas",
                      ),
                      onSaved: (String? value) {
                        _numPagesController.text = value.toString();
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
                      controller: _barcodeController,
                      decoration: const InputDecoration(
                        icon: Icon(CupertinoIcons.barcode),
                        border: OutlineInputBorder(),
                        labelText: "Cód. Barras",
                      ),
                      onSaved: (String? value) {
                        _barcodeController.text = value.toString();
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
                      controller: _genderController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.favorite),
                        border: OutlineInputBorder(),
                        labelText: "Gênero",
                      ),
                      onSaved: (String? value) {
                        _genderController.text = value.toString();
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
                      controller: _amountController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.pin_outlined),
                        border: OutlineInputBorder(),
                        labelText: "Quantidade de livros",
                      ),
                      onSaved: (String? value) {
                        _amountController.text = value.toString();
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
                      controller: _isbnController,
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
                        _isbnController.text = value.toString();
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

                  //botoes
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          BookService().updateBook(
                              book.id,
                              _titleController.text, //

                              _editionController.text,
                              _publishingCompanyController.text,
                              _yearPublicationController.text,
                              _numPagesController.text,
                              _barcodeController.text,
                              _genderController.text,
                              int.parse(_amountController.text),
                              book.companyId,
                              _isbnController.text);
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
              )),
        ),
      ),
    );
  }
}
