import 'dart:convert';

import 'package:librazza/functions/api_constants.dart';
import 'package:librazza/models/author.dart';
import 'package:http/http.dart' as http;

class ApiServiceAuthor {
  final String url = Api.baseUrl + Api.authorEndpoint;

/*
  Future<List<Author>> fetchAuthor() async {
    final response = await http.get(Uri.parse(url));
    return response;
  }*/

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
}
