class Book {
  final int id;
  final String title;
  final String edition;
  final String publishingCompany;
  final String yearPublication;
  final String numPages;
  final String barcode;
  final String gender;
  final int amount;
  final int companyId;
  final String isbn;
  int? localizationId;

  Book(
      {required this.id,
      required this.title,
      required this.edition,
      required this.publishingCompany,
      required this.yearPublication,
      required this.numPages,
      required this.barcode,
      required this.gender,
      required this.amount,
      required this.companyId,
      required this.isbn,
      this.localizationId});

  Map<String, dynamic> toJson() => {
        'titulo': title,
        'edicao': edition,
        'editora': publishingCompany,
        'ano_publicacao': yearPublication,
        'num_paginas': numPages,
        'cod_barras': barcode,
        'genero': gender,
        //'disponivel' : amount,
        'quantidade': amount,
        'empresa_id': companyId,
        'isbn': isbn,
        //localização
      };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        title: json['titulo'],
        edition: json['edicao'].toString(),
        publishingCompany: json['editora'],
        yearPublication: json['ano_publicacao'].toString(),
        numPages: json['num_paginas'].toString(),
        barcode: json['cod_barras'],
        gender: json['genero'],
        companyId: json['empresa_id'],
        isbn: json['isbn'],
        amount: json['quantidade']);
  }
}
