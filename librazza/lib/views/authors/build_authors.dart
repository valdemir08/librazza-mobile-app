import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/author.dart';
import 'dart:math';

import 'package:librazza/services/api_service_author.dart';
import 'package:librazza/views/authors/ListAll.dart';
import 'package:librazza/views/authors/edit_form.dart';

class BuildAuthors extends StatelessWidget {
  BuildAuthors({Key? key, this.authors, this.listAllState}) : super(key: key);
  final List<Author>? authors;
  var listAllState;

  final List<MaterialColor> colors = [Colors.blue];
  //int randomNumber = Ramdom().

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const NeverScrollableScrollPhysics(), //proprieda para evitar o erro do scrol
      shrinkWrap: true, //proprieda para evitar o erro do scrol
      itemCount: authors?.length,
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
                child: Text(authors![index].name.toString()[0])
                //Text(
                //(index + 1).toString()),

                //style: TextStyle(fontWeight: FontWeight.w500
                ),
            title: Text(authors![index].name.toString()),
            subtitle: Text("ID: ${authors![index].id}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              //remove a sobreposição do nome "Trailing widget consumes entire tile width."
              children: [
                IconButton(
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditForm(author: authors![index])),
                          ),
                        },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await DeleteItem(
                              id: authors![index].id,
                              listAllState: this.listAllState)
                          .showDeleteDialog(context);
                      //ApiServiceAuthor().deleteAuthor(authors![index].id);
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
