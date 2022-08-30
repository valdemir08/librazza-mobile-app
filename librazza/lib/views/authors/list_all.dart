import 'dart:async';

import 'package:flutter/material.dart';
import 'package:librazza/models/author.dart';
import 'package:librazza/views/authors/register_view.dart';
import 'package:librazza/services/author.dart';
import 'package:librazza/views/authors/build_authors.dart';

class ListAll extends StatefulWidget {
  const ListAll({Key? key}) : super(key: key);

  @override
  State<ListAll> createState() => _ListAllState();
}

class _ListAllState extends State<ListAll> {
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  late Future<List<Author>> authors;
  Future<List<Author>> refreshData() {
    setState(() {
      authors = AuthorService().getAuthors();
    });

    return authors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autores"),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
            child: FutureBuilder<List<Author>>(
                future: authors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text("Snapshot Error: ${snapshot.error}"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50)),
                              onPressed: () => refreshData(),
                              child: const Text("Refresh Data"),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return BuildAuthors(
                          authors: snapshot.data, listAllState: this);
                    } else {
                      return const Text('Ainda não há autores cadastrados');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterView()),
        ),
        tooltip: 'Adicionar autor',
        child: const Icon(Icons.add),
      ),
    );
  }
}
