class Pokemon {
  final String name;
  final String url;
  final int id;

  Pokemon({required this.name, required this.url, required this.id});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final urlParts = json['url'].split('/');
    final id = int.parse(urlParts[urlParts.length - 2]);

    return Pokemon(name: json['name'], url: json['url'], id: id);
  }
}
