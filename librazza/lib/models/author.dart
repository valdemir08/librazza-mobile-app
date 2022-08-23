import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/functions/api_constants.dart';

class Author {
  final int id;
  final String? name;

  Author({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        'nome': name,
      };

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['nome'],
    );
  }

  @override
  String toString() {
    return '{id: $this.id, name: $this.name}';
  }
}

Future<Author> createAuthor(String name) async {
  final response = await http.post(
    Uri.parse(Api.baseUrl + Api.authorEndpoint + "/add/"),
    body: {"nome": name}, //jsonEncode não estava funcionando
  );

  if (response.statusCode == 201) {
    return Author.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Falha na criação de empresa");
  }
}

Future<List<Author>> getAuthors() async {
  final response = await http.get(Uri.parse(Api.baseUrl + Api.authorEndpoint));
  List<Author> authors = (json.decode(response.body) as List)
      .map((data) => Author.fromJson(data))
      .toList();
  print(authors);
  return authors;
}

Future<Author> fetchAuthor() async {
  final response = await http.get(Uri.parse(Api.baseUrl + Api.authorEndpoint));

  if (response.statusCode == 200) {
    return Author.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Author');
  }
}

Future<http.Response> getResponse() async {
  var response = await http.get(Uri.parse(Api.baseUrl + Api.authorEndpoint));
  return response;
}
