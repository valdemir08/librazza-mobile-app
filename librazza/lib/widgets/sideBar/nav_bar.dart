// ignore_for_file: file_names

import 'package:flutter/material.dart';
//import 'package:librazza/functions/ExitApp.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/views/customers/list_all.dart' as customers;
import 'package:librazza/views/authors/list_all.dart' as authors;
import 'package:librazza/views/employees/list_all.dart' as employees;
import 'package:librazza/views/books/list_all.dart' as books;
import 'package:librazza/views/loans/list_all.dart' as loans;

//import '../../functions/exit_app.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.employe}) : super(key: key);

  final Employe employe;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(employe.name),
            accountEmail: Text(employe.email),
            currentAccountPicture: const CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.person, size: 60),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.brown,
              //image:
            ),
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text('Empréstimos'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const loans.ListAll()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Clientes'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => customers.ListAll(
                        employe: employe,
                      )),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Livros'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => books.ListAll(
                        employe: employe,
                      )),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Autores'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const authors.ListAll()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.badge),
            title: const Text('Funcionários'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const employees.ListAll()),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => ExitApp().showExitDialog(context),
          ),
        ],
      ),
    );
  }
}
