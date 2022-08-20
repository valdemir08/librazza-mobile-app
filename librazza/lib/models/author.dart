import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/functions/api_constants.dart';

class Author {
  final int id;
  final String name;

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
}

Future<Author> createAuthor(String name) async {
  final response = await http.post(
    Uri.parse(ApiConstants.baseUrl + ApiConstants.authorEndpoint + "/add/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nome': name,
    }),
  );

  if (response.statusCode == 201) {
    print("qwerty");
    return Author.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Falha na criação de empresa");
  }
}
