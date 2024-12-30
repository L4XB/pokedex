import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/data/repositories/pokemon_repositorie.dart';
import 'package:pokedex/src/features/home/domain/pokemon_general_informtion_model.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';

class PokemonProvider extends ChangeNotifier {
  PokemonRepositorie repositorie = PokemonRepositorie();
  List<PokemonModel> pokemons = [];
  int offset = 0;
  int limit = 20;

  void getPokemons() async {
    List<PokemonGeneralInformtionModel> pokemonGeneralData = await repositorie
            .getPokemonGeneralInfomrationsWithLimitAndOffset(limit, offset) ??
        [];
    if (pokemonGeneralData.isNotEmpty) {
      List<PokemonModel> models =
          await repositorie.getPokemonDataByUrlAndName(pokemonGeneralData);
      pokemons.addAll(models);
    }

    notifyListeners();
  }
}
