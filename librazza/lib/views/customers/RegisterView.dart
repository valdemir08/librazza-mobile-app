import 'package:flutter/material.dart';
import 'package:librazza/views/customers/RegisterForm.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar cliente"),
      ),
      body: const SingleChildScrollView(
        child: RegisterForm(),
      ),
    );
  }
}
