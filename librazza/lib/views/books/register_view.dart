import 'package:flutter/material.dart';
import 'package:librazza/views/books/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar livro"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: RegisterForm(),
      ),
    );
  }
}
