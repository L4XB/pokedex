import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/application/color_desicion.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel item;
  const PokemonCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: getColorForType(item.type),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: getColorForType(item.type), width: 3),
          ),
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -5,
          right: -10,
          child: Image.network(
            item.imageURL,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
