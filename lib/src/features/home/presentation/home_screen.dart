import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/data/repositories/pokemon_repositorie.dart';
import 'package:pokedex/src/features/home/domain/pokemon_general_informtion_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              List<PokemonGeneralInformtionModel> data =
                  await PokemonRepositorie()
                          .getPokemonGeneralInfomrationsWithLimitAndOffset(
                              20, 0) ??
                      [];
              for (PokemonGeneralInformtionModel model in data) {
                print(model.name);
              }
            },
            child: const Text("Load Data")),
      ),
    );
  }
}
