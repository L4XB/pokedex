import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokedex/src/common/utils/utils.dart';
import 'package:pokedex/src/features/classification/data/repositories/classification_repository.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:pokedex/src/features/search/data/provider/search_provider.dart';
import 'package:provider/provider.dart';

class ImagePickerButton extends StatelessWidget {
  final Function(List<PokemonModel>) onResults;

  const ImagePickerButton({super.key, required this.onResults});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    return GestureDetector(
      onTap: () async {
        File? image = await Utils().pickImageFromGallery();
        if (image != null) {
          String classification =
              await ClassificationRepository().classifiyImage(image);
          List<PokemonModel> matchedPokemons =
              await provider.searchPokemonThatMatches(classification);

          onResults(matchedPokemons);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.red.shade900,
              Colors.red.shade700,
              Colors.red.shade500,
              Colors.red.shade300,
            ],
            stops: const [0.1, 0.4, 0.7, 1.0],
          ),
        ),
      ),
    );
  }
}
