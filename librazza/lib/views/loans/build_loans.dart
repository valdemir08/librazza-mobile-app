import 'package:flutter/material.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/loan.dart';
import 'package:librazza/models/employe.dart';
import 'dart:math';

import 'package:librazza/views/loans/edit_form.dart';

class BuildLoans extends StatelessWidget {
  BuildLoans({Key? key, this.loans, this.listAllState, required this.employe})
      : super(key: key);
  final List<Loan>? loans;
  var listAllState;
  final Employe employe;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //proprieda para evitar o erro do scrol
      shrinkWrap: true, //proprieda para evitar o erro do scrol
      itemCount: loans?.length,
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
                child: Text(loans![index].openDate.toString()[0])),
            title: Text(loans![index].openDate.toString()),
            subtitle: Text(
                "Ed: ${loans![index].returnPeriod} Gên: ${loans![index].bookId}}"),
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
                                builder: (context) => EditForm(
                                      loan: loans![index],
                                      employe: employe,
                                    )),
                          ),
                        },
                    icon: const Icon(Icons.edit)),
                //delete butom
                IconButton(
                    onPressed: () async {
                      await DeleteItem(
                              item: loans![index], listAllState: listAllState)
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
