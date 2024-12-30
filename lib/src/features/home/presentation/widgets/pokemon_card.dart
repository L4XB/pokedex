import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/application/color_desicion.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel item;
  const PokemonCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: getColorForType(item.type),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: getColorForType(item.type), width: 3),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
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
                const SizedBox(height: 8),
                Material(
                  elevation: 3,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: getColorForType(item.type).withOpacity(0.4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      child: Text(
                        item.type,
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -25,
              right: -25,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  "assets/pokeball_background_image.png",
                  height: 125,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              right: -40,
              child: Image.network(
                item.imageURL,
                width: 140,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
