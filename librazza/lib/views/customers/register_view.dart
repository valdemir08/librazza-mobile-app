import 'package:flutter/material.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/views/customers/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key, required this.employe}) : super(key: key);
  final Employe employe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar cliente"),
      ),
      body: SingleChildScrollView(
        child: RegisterForm(employe: employe),
      ),
    );
  }
}
