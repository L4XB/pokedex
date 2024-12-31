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
        color: getColorForType(item.types[0]),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: getColorForType(item.types[0]), width: 3),
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
                const SizedBox(
                  height: 8,
                ),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var element in item.types)
                      Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 1,
                            color: const Color.fromARGB(103, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 14),
                                child: Text(
                                  element,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
            Positioned(
                bottom: 130,
                right: 0,
                child: Text(
                  item.id,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: getColorForType(item.types[0])),
                )),
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
