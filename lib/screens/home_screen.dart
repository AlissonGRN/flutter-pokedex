import 'package:flutter/material.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/screens/settings_screen.dart';
import '../services/poke_api_service.dart';
import '../widgets/pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokeApiService _apiService = PokeApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Pokemon> _allPokemons = [];

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    try {
      final pokemons = await _apiService.fetchPokemons();
      setState(() => _allPokemons = pokemons);
    } catch (e) {
      // Adicione um Snackbar para mostrar o erro
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  List<Pokemon> get _filteredPokemons {
    if (_searchController.text.isEmpty) return _allPokemons;
    return _allPokemons
        .where((p) => p.name.contains(_searchController.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(hintText: 'Buscar Pokémon...'),
          onChanged: (_) => setState(() {}),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
        ),
        itemCount: _filteredPokemons.length,
        itemBuilder:
            (ctx, index) => PokemonCard(pokemon: _filteredPokemons[index]),
      ),
    );
  }
}
