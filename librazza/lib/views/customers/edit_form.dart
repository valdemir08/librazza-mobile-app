import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librazza/models/customer.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/customer.dart';
import 'package:librazza/views/customers/list_all.dart';

class EditForm extends StatefulWidget {
  final Customer customer;
  final Employe employe;
  final listAll;

  EditForm(
      {Key? key,
      required this.customer,
      required this.employe,
      required this.listAll})
      : super(key: key);
  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  late final Customer customer = widget.customer;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController =
      TextEditingController(text: customer.name);

  late final TextEditingController _cpfController =
      TextEditingController(text: customer.cpf);

  late final TextEditingController _phoneNumberController =
      TextEditingController(text: customer.phoneNumber);

  late final TextEditingController _emailController =
      TextEditingController(text: customer.email);

  late final TextEditingController _birthDateController =
      TextEditingController(text: customer.birthDate);

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
                  //nome
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: "Nome",
                      ),
                      keyboardType: TextInputType.text,
                      onSaved: (String? value) {
                        _nameController.text = value.toString();
                      },
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
                      //inputFormatters: [mask.cpfFormater],
                      decoration: const InputDecoration(
                        icon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                        labelText: "Cpf",
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (String? value) {
                        _cpfController.text = value!;
                      },
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
                      //inputFormatters: [mask.phoneNumberFormater],
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: "Telefone",
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (String? value) {
                        _phoneNumberController.text = value!;
                        //mask.phoneNumberFormater.getUnmaskedText();
                      },
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
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? value) {
                        _emailController.text = value.toString();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe o email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  //data aniversario
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          CustomerService().updateCustomer(
                              customer.id,
                              _nameController.text,
                              _cpfController.text,
                              _phoneNumberController.text,
                              _emailController.text,
                              _birthDateController.text);

                          await widget.listAll.refreshData();

                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListAll(employe: widget.employe)),
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
