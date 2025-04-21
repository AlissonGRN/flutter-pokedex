import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/model/pokemon_details.dart';

class PokeApiService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemons({int offset = 0}) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=1025',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List)
            .map((p) => Pokemon.fromJson(p))
            .toList();
      } else {
        throw Exception('Falha ao carregar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na conexão: $e');
    }
  }

  Future<PokemonDetails> fetchPokemonDetails(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/pokemon/$id'));

    if (response.statusCode == 200) {
      return PokemonDetails.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load details');
    }
  }
}
