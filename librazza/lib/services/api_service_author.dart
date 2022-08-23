import 'dart:convert';

import 'package:librazza/functions/api_constants.dart';
import 'package:librazza/models/author.dart';
import 'package:http/http.dart' as http;

class ApiServiceAuthor {
  final String url = Api.baseUrl + Api.authorEndpoint;

// ignore: slash_for_doc_comments
/**
  Future<Author> fetchAuthor() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Author.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Author');
    }
  }
 */

  Future<List<Author>> getAuthors() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Author> authors =
          body.map((dynamic item) => Author.fromJson(item)).toList();
      return authors;
    } else {
      throw "Falha ao carregar lista de autores";
    }
  }

  Future<Author> getAuthorById(int id) async {
    http.Response response = await http.get(Uri.parse("$url/$id"));

    if (response.statusCode == 200) {
      return Author.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao carregar author por id");
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
      throw Exception("Falha na criação de autor");
    }
  }
}
