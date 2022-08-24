import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:librazza/functions/api_constants.dart';
import 'package:librazza/models/author.dart';
import 'package:librazza/views/authors/RegisterView.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/services/api_service_author.dart';
import 'package:librazza/widgets/build_authors.dart';

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
      authors = ApiServiceAuthor().getAuthors();
    });

    return authors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autores"),
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
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text("Snapshot Error: ${snapshot.error}"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(200, 50)),
                              onPressed: () => refreshData(),
                              child: const Text("Refresh Data"),
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return BuildAuthors(items: snapshot.data);
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
