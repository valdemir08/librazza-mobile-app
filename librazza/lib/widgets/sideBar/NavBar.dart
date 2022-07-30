import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librazza/functions/ExitApp.dart';
import 'package:librazza/views/customers/CustomersList.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
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
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Clientes'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomersList()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Livros'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Autores'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.badge),
            title: const Text('Funcionários'),
            onTap: () => null,
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
