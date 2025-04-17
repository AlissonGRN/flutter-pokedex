class PokemonDetails {
  final int id;
  final String name;
  final List<String> types;
  final int height;
  final int weight;
  final List<Stat> stats;
  final String imageUrl;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.stats,
  }) : imageUrl =
           'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      id: json['id'],
      name: json['name'],
      types:
          (json['types'] as List)
              .map((t) => t['type']['name'] as String)
              .toList(),
      height: json['height'],
      weight: json['weight'],
      stats: (json['stats'] as List).map((s) => Stat.fromJson(s)).toList(),
    );
  }
}

class Stat {
  final String name;
  final int value;

  Stat({required this.name, required this.value});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(name: json['stat']['name'], value: json['base_stat']);
  }
}
