import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pokemon_details.dart';
import '../providers/favotite_provider.dart';
import '../services/poke_api_service.dart';
import '../utils/type_color.dart';
import '../widgets/type_chip.dart';

class DetailsScreen extends StatelessWidget {
  final int pokemonId;

  const DetailsScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    // ignore: unused_local_variable
    final theme = Theme.of(context);

    return FutureBuilder<PokemonDetails>(
      future: PokeApiService().fetchPokemonDetails(pokemonId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Erro: ${snapshot.error}')));
        }

        final pokemon = snapshot.data!;
        final primaryColor = getTypeColor(pokemon.types.first);

        return Scaffold(
          backgroundColor: primaryColor.withOpacity(0.2),
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(pokemon.name),
            actions: [
              IconButton(
                icon: Icon(
                  favoriteProvider.favorites.contains(pokemonId)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () => favoriteProvider.toggleFavorite(pokemonId),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(pokemon.imageUrl, height: 200),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:
                            pokemon.types
                                .map((type) => TypeChip(type: type))
                                .toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Altura: ${pokemon.height / 10} m',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Peso: ${pokemon.weight / 10} kg',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Estatísticas:',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      ...pokemon.stats.map(
                        (stat) => ListTile(
                          title: Text(
                            stat.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Text(
                            stat.value.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
