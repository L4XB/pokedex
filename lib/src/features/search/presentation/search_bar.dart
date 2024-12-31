import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:pokedex/src/features/search/data/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(List<PokemonModel>) updateSearchResults;

  const SearchBarWidget({super.key, required this.updateSearchResults});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          onSubmitted: (query) async {
            List<PokemonModel> searchedPokemon =
                await provider.searchPokemons(query);
            updateSearchResults(searchedPokemon);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey[600]),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
