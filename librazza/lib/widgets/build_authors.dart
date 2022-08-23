import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:librazza/models/author.dart';

class BuildAuthors extends StatelessWidget {
  const BuildAuthors({Key? key, this.items}) : super(key: key);
  final List<Author>? items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items?.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 6,
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ListTile(
            visualDensity: VisualDensity(vertical: 4), // to expand

            leading: CircleAvatar(
              backgroundColor: Colors.brown,
              child: Text((index + 1).toString()),
            ),
            title: Text(items![index].name.toString()),
            //subtitle: Text(items![index].id.toString()),
            trailing: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
