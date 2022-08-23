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

  Future<List<Author>> authors = ApiServiceAuthor().getAuthors();
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
      body: Center(
          child: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: FutureBuilder<List<Author>>(
            future: authors,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? BuildAuthors(items: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            }),
      )),
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
