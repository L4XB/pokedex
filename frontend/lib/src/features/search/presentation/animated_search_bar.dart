import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:pokedex/src/features/search/presentation/search_bar.dart';

class AnimatedSearchBar extends StatelessWidget {
  final bool isVisible;
  final VoidCallback toggleVisibility;
  final Function(List<PokemonModel>) updateSearchResults;

  const AnimatedSearchBar({
    super.key,
    required this.isVisible,
    required this.toggleVisibility,
    required this.updateSearchResults,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isVisible ? MediaQuery.of(context).size.width - 55 : 0,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: SearchBarWidget(
              updateSearchResults: updateSearchResults,
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            icon: Icon(
              isVisible ? Icons.close : null,
              size: 28,
            ),
            onPressed: toggleVisibility,
          ),
        ],
      ),
    );
  }
}
