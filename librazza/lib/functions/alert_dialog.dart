import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librazza/services/api_service_author.dart';

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
  final int id;

  final listAllState;

  const DeleteItem({required this.id, required this.listAllState});

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
          onPressed: () => {
            ApiServiceAuthor().deleteAuthor(id),
            listAllState.refreshData(),
            Navigator.of(context).pop(false)
          },
          child: const Text("SIM"),
        ),
      ],
    );
  }
}
