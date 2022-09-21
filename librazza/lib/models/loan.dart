class Loan {
  final int id;
  final String openDate;
  //final int returnPeriod;
  final String closeDate;
  final String status;
  final int customerId;
  final int employeId;
  final int bookId;

  Loan({
    required this.id,
    required this.openDate,
    //required this.returnPeriod,
    required this.closeDate,
    required this.status,
    required this.customerId,
    required this.employeId,
    required this.bookId,
  });

  Map<String, dynamic> toJson() => {
        'data_inicio': openDate,
        //'prazo_devolucao': returnPeriod,
        'data_devolucao': closeDate,
        'status': status,
        'cliente_id': customerId,
        'funcionario_id': employeId,
        'livro_id': bookId,
      };

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      openDate: json['data_inicio'],
      //returnPeriod: json['prazo_devolucao'],
      closeDate: json['data_devolucao'],
      status: json['status'],
      customerId: json['cliente_id'],
      employeId: json['funcionario_id'],
      bookId: json['livro_id'],
    );
  }
}
