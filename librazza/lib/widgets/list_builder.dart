import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: authors == null ? 0 : authors.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailWidget(authors[index])),
                );
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(authors[index].name),
                subtitle: Text(authors[index].id.toString()),
              ),
            ),
          );
        });
  }
}
