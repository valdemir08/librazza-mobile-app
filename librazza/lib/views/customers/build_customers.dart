import 'package:flutter/material.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/customer.dart';
import 'package:librazza/models/employe.dart';
import 'dart:math';

import 'package:librazza/views/customers/edit_form.dart';

class BuildCustomers extends StatelessWidget {
  BuildCustomers(
      {Key? key, this.customers, this.listAllState, required this.employe})
      : super(key: key);
  final List<Customer>? customers;
  final Employe employe;
  var listAllState;

  final List<MaterialColor> colors = [Colors.blue];
  //int randomNumber = Ramdom().

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //proprieda para evitar o erro do scrol
      shrinkWrap: true, //proprieda para evitar o erro do scrol
      itemCount: customers?.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ListTile(
            visualDensity: VisualDensity(vertical: 1), // to expand

            leading: CircleAvatar(
                backgroundColor:
                    Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0),
                child: Text(customers![index].name.toString()[0])
                //Text(
                //(index + 1).toString()),

                //style: TextStyle(fontWeight: FontWeight.w500
                ),
            title: Text(customers![index].name.toString()),
            subtitle: Text("${customers![index].email}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              //remove a sobreposição do nome "Trailing widget consumes entire tile width."
              children: [
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditForm(
                                    customer: customers![index],
                                    employe: employe)),
                          ),
                        },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await DeleteItem(
                              item: customers![index],
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
