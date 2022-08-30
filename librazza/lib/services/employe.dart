import 'dart:convert';

import 'package:librazza/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/models/employe.dart';

class EmployeService {
  final String url = Api.baseUrl + Api.employeesEndpoint;

  Future<List<Employe>> getEmployees() async {
    http.Response response = await http.get(Uri.parse("$url/"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Employe> employees =
          body.map((dynamic item) => Employe.fromJson(item)).toList();
      return employees;
    } else {
      throw "Falha ao carregar lista de funcionários";
    }
  }

  Future<Employe> getEmployeById(int id) async {
    http.Response response = await http.get(Uri.parse("$url/$id/"));

    if (response.statusCode == 200) {
      return Employe.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao carregar funcionário por id");
    }
  }

  Future<Employe> createEmploye(
      String registration,
      String password,
      String name,
      String cpf,
      String phoneNumber,
      String email,
      String birthDate,
      int companyId) async {
    http.Response response = await http.post(
      Uri.parse("$url/add/"),

      body: {
        'matricula': registration,
        'senha': password,
        'nome': name,
        'cpf': cpf,
        'telefone': phoneNumber,
        'email': email,
        'data_nascimento': birthDate,
        'empresa_id': companyId.toString()
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 201) {
      return Employe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha na criação de funcionário");
    }
  }

  Future<Employe> updateEmploye(
      int id,
      String registration,
      String password,
      String name,
      String cpf,
      String phoneNumber,
      String email,
      String birthDate,
      int companyId) async {
    http.Response response = await http.put(
      Uri.parse("$url/$id/"),
      /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, */
      body: {
        'matricula': registration,
        'senha': password,
        'nome': name,
        'cpf': cpf,
        'telefone': phoneNumber,
        'email': email,
        'data_nascimento': birthDate,
        'empresa_id': companyId.toString()
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 200) {
      return Employe.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha na atualização de Funcionário");
    }
  }

  Future<Employe> deleteEmploye(int id) async {
    http.Response response = await http
        .delete(Uri.parse("$url/delete/$id/"), headers: <String, String>{
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Referer": "http://10.0.0.143:5000/funcionario/delete/$id/",
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 201) {
      return Employe.fromJson(jsonDecode(response.body));
    } else {
      throw "Falha ao deletar funcionário";
    }
  }
}
