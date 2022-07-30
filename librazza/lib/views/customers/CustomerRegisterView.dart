import 'package:flutter/material.dart';
import 'package:librazza/views/customers/CustomerRegisterForm.dart';

class CustomerRegisterView extends StatelessWidget {
  const CustomerRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar cliente"),
      ),
      body: const CustomerRegisterForm(),
    );
  }
}
