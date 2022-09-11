import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/services/employe.dart';
import 'package:librazza/views/employees/list_all.dart';
import 'package:librazza/widgets/mask_formatter.dart' as mask;

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();
  late String _registration,
      _name,
      _cpf,
      _phoneNumber,
      _email,
      _password,
      _birthDate;
  Future<Employe>? _futureEmploye;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //matricula
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: "Matrícula",
                ),
                onSaved: (String? value) {
                  _registration = value.toString();
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
            //inputs
            //nome
            Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: "Nome",
                ),
                onSaved: (String? value) {
                  _name = value.toString();
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
                inputFormatters: [mask.cpfFormater],
                decoration: const InputDecoration(
                  icon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                  labelText: "Cpf",
                ),
                onSaved: (String? value) {
                  _cpf = mask.cpfFormater.getUnmaskedText();
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
                inputFormatters: [mask.phoneNumberFormater],
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: "Telefone",
                ),
                onSaved: (String? value) {
                  _phoneNumber = mask.phoneNumberFormater.getUnmaskedText();
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
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                onSaved: (String? value) {
                  _email = value.toString();
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
                    FocusScope.of(context)
                        .requestFocus(FocusNode()); //remove a subida do teclado
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
                    _birthDate = value.toString();
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
                    _futureEmploye = EmployeService().createEmploye(
                        _registration, //matricula == id
                        _password,
                        _name,
                        _cpf,
                        _phoneNumber,
                        _email,
                        _birthDate,
                        1);

                    print(_futureEmploye.toString());
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListAll()),
                    );

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
