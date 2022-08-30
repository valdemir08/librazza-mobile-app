// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librazza/services/author.dart';
import 'package:librazza/services/employe.dart';

class ExitApp {
  Future<bool?> showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => buildExitDialog(context),
    );
  }

  AlertDialog buildExitDialog(BuildContext context) {
    return AlertDialog(
      //title: const Text("Confirmar"),
      content: const Text("SAIR DO APP?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("NÃO"),
        ),
        TextButton(
          onPressed: () => {
            if (Platform.isAndroid || Platform.isWindows)
              {SystemNavigator.pop()}
            else if (Platform.isIOS)
              {exit(0)}
          },
          child: const Text("SIM"),
        ),
      ],
    );
  }
}

class DeleteItem {
  final item;

  final listAllState;

  const DeleteItem({required this.item, required this.listAllState});

  Future<bool?> showDeleteDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildDeleteDialog(context),
    );
  }

  AlertDialog _buildDeleteDialog(BuildContext context) {
    return AlertDialog(
      //title: const Text("Confirmar"),
      content: const Text("DESEJA EXCLUIR ESTE ITEM?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("NÃO"),
        ),
        TextButton(
          onPressed: () {
            switch (item.runtimeType.toString()) {
              case "Author":
                AuthorService().deleteAuthor(item.id);
                break;
              /*case "Book":
                AuthorService().deleteAuthor(item.id);
              break;
              case "Customer":
                AuthorService().deleteAuthor(item.id);
              break;*/
              case "Employe":
                EmployeService().deleteEmploye(item.id);
                break;
              /*case "Loan":
                AuthorService().deleteAuthor(item.id);
              break;*/

            }
            listAllState.refreshData();
            Navigator.of(context).pop(false);
          },
          child: const Text("SIM"),
        ),
      ],
    );
  }
}
