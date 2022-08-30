class Employe {
  final int id;
  final String registration;
  final String password;
  final String? name;
  final String cpf;
  final String phoneNumber;
  final String email;
  final String birthDate;
  final int companyId;

  Employe(
      {required this.id,
      required this.registration,
      required this.password,
      required this.name,
      required this.cpf,
      required this.phoneNumber,
      required this.email,
      required this.birthDate,
      required this.companyId});

  Map<String, dynamic> toJson() => {
        'matricula': registration,
        'senha': password,
        'nome': name,
        'cpf': cpf,
        'telefone': phoneNumber,
        'email': email,
        'data_nascimento': birthDate,
        'empresa_id': companyId,
      };

  factory Employe.fromJson(Map<String, dynamic> json) {
    return Employe(
        id: json['id'],
        registration: json['matricula'],
        password: json['senha'],
        name: json['nome'],
        cpf: json['cpf'],
        phoneNumber: json['telefone'],
        email: json['email'],
        birthDate: json['data_nascimento'],
        companyId: json['empresa_id']);
  }
}
