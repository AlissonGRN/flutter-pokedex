import 'package:flutter/material.dart';
import 'package:pokedex/providers/favotite_provider.dart';
import 'package:pokedex/screens/details_screen.dart';
import 'package:pokedex/widgets/type_chip.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/pokemon.dart';
import '../utils/type_color.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final primaryColor = getTypeColor(
      pokemon.types.isNotEmpty ? pokemon.types.first : 'normal',
    );

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailsScreen(pokemonId: pokemon.id),
            ),
          ),
      child: Card(
        elevation: Theme.of(context).brightness == Brightness.dark ? 3 : 5,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            // Background color based on type
            Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ID and Favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '#${pokemon.id.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        favoriteProvider.favorites.contains(pokemon.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed:
                          () => favoriteProvider.toggleFavorite(pokemon.id),
                    ),
                  ],
                ),
                // Pokémon Image
                Center(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const CircularProgressIndicator(),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
                ),
                // Pokémon Name
                Center(
                  child: Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                // Types
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:
                //       pokemon.types
                //           .take(2) // Limit to 2 types
                //           .map((type) => TypeChip(type: type))
                //           .toList(),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
