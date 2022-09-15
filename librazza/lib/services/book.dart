import 'dart:convert';

import 'package:librazza/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:librazza/models/book.dart';

class BookService {
  final String url = Api.baseUrl + Api.booksEndpoint;

  Future<List<Book>> getBooks() async {
    http.Response response = await http.get(Uri.parse("$url/"));

    if (response.statusCode == 200) {
      List<dynamic> body = await jsonDecode(response.body);
      List<Book> books =
          body.map((dynamic item) => Book.fromJson(item)).toList();
      return books;
    } else {
      throw "Falha ao carregar lista de livros";
    }
  }

  Future<Book> getBookById(int id) async {
    http.Response response = await http.get(Uri.parse("$url/$id/"));

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao carregar livro por id");
    }
  }

  Future<bool> createBook(
      String title,
      String edition,
      String publishingCompany,
      String yearPublication,
      String numPages,
      String barcode,
      String gender,
      int amount,
      int companyId,
      String isbn,
      int authorId) async {
    http.Response response = await http.post(
      Uri.parse("$url/add/"),

      body: {
        'titulo': title,
        'edicao': edition.toString(),
        'editora': publishingCompany,
        'ano_publicacao': yearPublication.toString(),
        'num_paginas': numPages,
        'cod_barras': barcode,
        'genero': gender,
        'quantidade': amount.toString(),
        'empresa_id': companyId.toString(),
        'isbn': isbn,
        'autor': authorId,
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception("Falha na criação de livro");
    }
  }

  Future<bool> updateBook(
      int id,
      String title,
      String edition,
      String publishingCompany,
      String yearPublication,
      String numPages,
      String barcode,
      String gender,
      int amount,
      int companyId,
      String isbn) async {
    http.Response response = await http.put(
      Uri.parse("$url/$id/"),
      /* headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, */
      body: {
        'titulo': title,
        'edicao': edition.toString(),
        'editora': publishingCompany,
        'ano_publicacao': yearPublication.toString(),
        'num_paginas': numPages,
        'cod_barras': barcode,
        'genero': gender,
        'quantidade': amount.toString(),
        'empresa_id': companyId.toString(),
        'isbn': isbn,
      }, //jsonEncode não estava funcionando
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Falha na atualização de livro");
    }
  }

  Future<Book> deleteBook(int id) async {
    http.Response response = await http
        .delete(Uri.parse("$url/delete/$id/"), headers: <String, String>{
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
      "Referer": "http://10.0.0.143:5000/funcionario/delete/$id/",
      'Content-Type': 'application/json; charset=UTF-8'
    });

    if (response.statusCode == 201) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw "Falha ao deletar livro";
    }
  }
}
