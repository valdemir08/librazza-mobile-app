import 'package:flutter/material.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/book.dart';
import 'package:librazza/models/employe.dart';
import 'dart:math';

import 'package:librazza/views/books/edit_form.dart';

class BuildBooks extends StatelessWidget {
  BuildBooks({Key? key, this.books, this.listAllState, required this.employe})
      : super(key: key);
  final List<Book>? books;
  var listAllState;
  final Employe employe;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //proprieda para evitar o erro do scrol
      shrinkWrap: true, //proprieda para evitar o erro do scrol
      itemCount: books?.length,
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
                child: Text(books![index].title.toString()[0])
                //Text(
                //(index + 1).toString()),

                //style: TextStyle(fontWeight: FontWeight.w500
                ),
            title: Text(books![index].title.toString()),
            subtitle: Text(
                "Ed: ${books![index].edition} Gên: ${books![index].gender} Qtd: ${books![index].amount}"),
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
                                      book: books![index],
                                      employe: employe,
                                    )),
                          ),
                        },
                    icon: const Icon(Icons.edit)),
                //delete butom
                IconButton(
                    onPressed: () async {
                      await DeleteItem(
                              item: books![index], listAllState: listAllState)
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
