import 'package:flutter/material.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/employe.dart';
import 'package:librazza/views/employees/list_all.dart';
import 'package:intl/intl.dart';
import 'package:librazza/widgets/mask_formatter.dart' as mask;

class EditForm extends StatefulWidget {
  final Employe employe;

  const EditForm({Key? key, required this.employe}) : super(key: key);

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  late final Employe employe = widget.employe;
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _registrationController =
      TextEditingController(text: employe.registration);

  late final TextEditingController _nameController =
      TextEditingController(text: employe.name);

  late final TextEditingController _cpfController =
      TextEditingController(text: employe.cpf);

  late final TextEditingController _phoneNumberController =
      TextEditingController(text: employe.phoneNumber);

  late final TextEditingController _emailController =
      TextEditingController(text: employe.email);

  late final TextEditingController _birthDateController = TextEditingController(
      text: employe.birthDate); //verificar como esta sendo passada essa data

  late final TextEditingController _passwordController =
      TextEditingController(text: employe.password);

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
                  //matricula
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _registrationController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: "Matrícula",
                      ),
                      onSaved: (String? value) {
                        _registrationController.text = value.toString();
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe a matrícula";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
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
                      validator: (value) {
                        if (value!.isEmpty) {
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
                      controller: _cpfController,
                      inputFormatters: [mask.cpfFormater],
                      decoration: const InputDecoration(
                        icon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                        labelText: "Cpf",
                      ),
                      onSaved: (String? value) {
                        _cpfController.text =
                            mask.cpfFormater.getUnmaskedText();
                      },
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
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
                      controller: _phoneNumberController,
                      inputFormatters: [mask.phoneNumberFormater],
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: "Telefone",
                      ),
                      onSaved: (String? value) {
                        _phoneNumberController.text =
                            mask.phoneNumberFormater.getUnmaskedText();
                      },
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.mail),
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                      onSaved: (String? value) {
                        _emailController.text = value.toString();
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
                  //data aniversario - verificar necessidade de troca
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                        controller: _birthDateController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data de nascimento",
                            icon: Icon(Icons.calendar_month_outlined)),
                        readOnly: true,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); //remove a subida do teclado
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            setState(() {
                              _birthDateController.text =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                            });
                          }
                        },
                        onSaved: (String? value) {
                          _birthDateController.text = value.toString();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe a data de nascimento";
                          } else {
                            return null;
                          }
                        },
                      )),
                  //senha
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: "Senha",
                      ),
                      onSaved: (String? value) {
                        _passwordController.text = value.toString();
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

                          EmployeService().updateEmploye(
                              employe.id,
                              _registrationController.text, //matricula == id
                              _passwordController.text,
                              _nameController.text,
                              _cpfController.text,
                              _phoneNumberController.text,
                              _emailController.text,
                              _birthDateController.text,
                              1);

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
