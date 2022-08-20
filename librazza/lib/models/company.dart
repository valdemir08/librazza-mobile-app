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
