class Pokemon {
  final String name;
  final String url;
  final int id;

  List<String> types = [];

  Pokemon({required this.name, required this.url, required this.id});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final urlParts = json['url'].split('/');
    final id = int.parse(urlParts[urlParts.length - 2]);

    print('Pokemon criado: ${json['name']} | ID: $id'); // Adicione esta linha
    return Pokemon(name: json['name'], url: json['url'], id: id);
  }
}
