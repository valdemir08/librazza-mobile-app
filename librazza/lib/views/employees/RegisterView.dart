import 'package:flutter/material.dart';
import 'package:librazza/views/employees/RegisterForm.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar funcionário"),
      ),
      body: const SingleChildScrollView(
        child: RegisterForm(),
      ),
    );
  }
}
