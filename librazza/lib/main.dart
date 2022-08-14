import 'package:flutter/material.dart';
import 'package:librazza/functions/ExitApp.dart';
import 'package:librazza/views/auth/Login.dart';
import 'package:librazza/widgets/sideBar/NavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      //home: const MyHomePage(title: 'LIBRAZZA'),
      home: const Login(),
    );
  }
}
