import 'dart:convert';

import 'package:librazza/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/models/loan.dart';

class LoanService {
  final String url = Api.baseUrl + Api.loansEndpoint;

  Future<List<Loan>> getLoans() async {
    http.Response response = await http.get(Uri.parse("$url/"));

    if (response.statusCode == 200) {
      List<dynamic> body = await jsonDecode(response.body);
      List<Loan> loans =
          body.map((dynamic item) => Loan.fromJson(item)).toList();
      return loans;
    } else {
      throw "Falha ao carregar lista de livros";
    }
  }

  Future<Loan> getLoanById(int id) async {
    http.Response response = await http.get(Uri.parse("$url/$id/"));

    if (response.statusCode == 200) {
      return Loan.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao carregar livro por id");
    }
  }

  Future<bool> createLoan(
      String initDate,
      String returnPeriod,
      String returnDate,
      String status,
      int customerId,
      int employeId,
      int bookId) async {
    http.Response response = await http.post(
      Uri.parse("$url/add/"),

      body: {
        'data_inicio': initDate,
        'prazo_devolucao': returnPeriod,
        'data_devolucao': returnDate,
        'status': status,
        'cliente_id': customerId,
        'funcionario_id': employeId,
        'livro_id': bookId,
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Falha na criação de empréstimo");
    }
  }

  Future<bool> updateLoan(
      int id,
      String openDate,
      String returnPeriod,
      String closeDate,
      String status,
      int customerId,
      int employeId,
      int bookId) async {
    http.Response response = await http.put(
      Uri.parse("$url/$id/"),
      /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, */
      body: {
        'data_inicio': openDate,
        'prazo_devolucao': returnPeriod,
        'data_devolucao': closeDate,
        'status': status,
        'cliente_id': customerId,
        'funcionario_id': employeId,
        'livro_id': bookId,
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Falha na atualização de livro");
    }
  }

  Future<Loan> deleteLoan(int id) async {
    http.Response response = await http
        .delete(Uri.parse("$url/delete/$id/"), headers: <String, String>{
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Referer": "http://10.0.0.143:5000/funcionario/delete/$id/",
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 201) {
      return Loan.fromJson(jsonDecode(response.body));
    } else {
      throw "Falha ao deletar livro";
    }
  }
}
