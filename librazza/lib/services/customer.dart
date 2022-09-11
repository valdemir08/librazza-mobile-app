import 'dart:convert';

import 'package:librazza/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/models/customer.dart';

class CustomerService {
  final String url = Api.baseUrl + Api.customersEndpont;

  Future<List<Customer>> getCustomers() async {
    http.Response response = await http.get(Uri.parse("$url/"));

    if (response.statusCode == 200) {
      List<dynamic> body = await jsonDecode(response.body);
      List<Customer> customers =
          body.map((dynamic item) => Customer.fromJson(item)).toList();
      return customers;
    } else {
      throw "Falha ao carregar lista de clientes";
    }
  }

  Future<Customer> getCustomerById(int id) async {
    http.Response response = await http.get(Uri.parse("$url/$id/"));

    if (response.statusCode == 200) {
      return Customer.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao carregar cliente por id");
    }
  }

  Future<bool> createCustomer(String name, String cpf, String phoneNumber,
      String email, String birthDate, int companyId) async {
    http.Response response = await http.post(
      Uri.parse("$url/add/"),

      body: {
        'nome': name,
        'cpf': cpf,
        'telefone': phoneNumber,
        'email': email,
        'data_nascimento': birthDate,
        'empresa_id': companyId.toString()
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Falha na criação de Cliente");
    }
  }

  Future<Customer> updateCustomer(
    int id,
    String name,
    String cpf,
    String phoneNumber,
    String email,
    String birthDate,
  ) async {
    http.Response response = await http.put(
      Uri.parse("$url/$id/"),
      /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, */
      body: {
        'nome': name,
        'cpf': cpf,
        'telefone': phoneNumber,
        'email': email,
        'data_nascimento': birthDate,
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 200) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha na atualização de Cliente");
    }
  }

  Future<Customer> deleteCustomer(int id) async {
    http.Response response = await http
        .delete(Uri.parse("$url/delete/$id/"), headers: <String, String>{
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Referer": "http://10.0.0.143:5000/cliente/delete/$id/",
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 201) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw "Falha ao deletar cliente";
    }
  }
}
