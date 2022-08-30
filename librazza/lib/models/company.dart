import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:librazza/functions/api_constants.dart';

class Company {
  final int id;
  final String name;
  final String cnpj;

  Company({required this.id, required this.name, required this.cnpj});

  Map<String, dynamic> toJson() => {
        'nome': name,
        'cnpj': cnpj,
      };

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['nome'],
      cnpj: json['cnpj'],
    );
  }
}

Future<Company> createCompany(String name, String cnpj) async {
  final response = await http.post(
    Uri.parse("${Api.companyEndpoint}/add"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nome': name,
      'cnpj': cnpj,
    }),
  );

  if (response.statusCode == 201) {
    return Company.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Falha na criação de empresa");
  }
}
