// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:librazza/functions/ExitApp.dart';
import 'package:librazza/views/customers/ListAll.dart' as customers;
import 'package:librazza/views/authors/ListAll.dart' as authors;
import 'package:librazza/views/employees/ListAll.dart' as employees;
import 'package:librazza/views/books/ListAll.dart' as books;
import 'package:librazza/views/loans/ListAll.dart' as loans;

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Fulano'),
            accountEmail: Text('fulano@librazza.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(Icons.person, size: 60),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
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
                  builder: (context) => const customers.ListAll()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Livros'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const books.ListAll()),
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
            onTap: () => const ExitApp().showExitDialog(context),
          ),
        ],
      ),
    );
  }
}
