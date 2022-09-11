class Customer {
  final int id;
  final String name;
  final String cpf;
  final String phoneNumber;
  final String email;
  final String birthDate;
  final int reliabilityId;
  final int companyId;

  Customer(
      {required this.id,
      required this.name,
      required this.cpf,
      required this.phoneNumber,
      required this.email,
      required this.birthDate,
      required this.reliabilityId,
      required this.companyId});

  Map<String, dynamic> toJson() => {
        'nome': name,
        'cpf': cpf,
        'telefone': phoneNumber,
        'email': email,
        'data_nascimento': birthDate,
        'empresa_id': companyId,
      };

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json['nome'],
        cpf: json['cpf'],
        phoneNumber: json['telefone'],
        email: json['email'],
        birthDate: json['data_nascimento'],
        reliabilityId: json['confiabilidade_id'],
        companyId: json['empresa_id']);
  }

  //Endereço?
}
