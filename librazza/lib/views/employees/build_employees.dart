import 'package:flutter/material.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/employe.dart';
import 'dart:math';

import 'package:librazza/views/employees/edit_form.dart';

class BuildEmployees extends StatelessWidget {
  BuildEmployees({Key? key, this.employees, this.listAllState})
      : super(key: key);
  final List<Employe>? employees;
  var listAllState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //proprieda para evitar o erro do scrol
      shrinkWrap: true, //proprieda para evitar o erro do scrol
      itemCount: employees?.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ListTile(
            visualDensity: const VisualDensity(vertical: 1), // to expand

            leading: CircleAvatar(
                backgroundColor:
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0),
                child: Text(employees![index].name.toString()[0])
                //Text(
                //(index + 1).toString()),

                //style: TextStyle(fontWeight: FontWeight.w500
                ),
            title: Text(employees![index].name.toString()),
            subtitle: Text("CPF: ${employees![index].cpf}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              //remove a sobreposição do nome "Trailing widget consumes entire tile width."
              children: [
                //edit button
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditForm(employe: employees![index])),
                          ),
                        },
                    icon: const Icon(Icons.edit)),
                //delete butom
                IconButton(
                    onPressed: () async {
                      await DeleteItem(
                              item: employees![index],
                              listAllState: listAllState)
                          .showDeleteDialog(context);
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
