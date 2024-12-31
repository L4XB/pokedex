import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:pokedex/src/features/search/data/provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(List<PokemonModel>) updateSearchResults;

  const SearchBarWidget({super.key, required this.updateSearchResults});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          controller: controller,
          onSubmitted: (query) async {
            List<PokemonModel> searchedPokemon =
                await provider.searchPokemons(query);
            widget.updateSearchResults(searchedPokemon);
            controller.clear();
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
