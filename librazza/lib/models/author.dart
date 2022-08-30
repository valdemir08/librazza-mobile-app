class Author {
  final int id;
  final String? name;

  Author({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
        'nome': name,
      };

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['nome'],
    );
  }

  @override
  String toString() {
    return '{id: $this.id, name: $this.name}';
  }
}
