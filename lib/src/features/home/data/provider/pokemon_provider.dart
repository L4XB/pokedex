import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/data/repositories/pokemon_repositorie.dart';
import 'package:pokedex/src/features/home/domain/pokemon_general_informtion_model.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';

class PokemonProvider extends ChangeNotifier {
  PokemonRepositorie repositorie = PokemonRepositorie();

  Future<List<PokemonModel>> getPokemons(int pageKey, int pageSize) async {
    List<PokemonGeneralInformtionModel> pokemonGeneralData =
        await repositorie.getPokemonGeneralInfomrationsWithLimitAndOffset(
                pageSize, pageKey) ??
            [];
    if (pokemonGeneralData.isNotEmpty) {
      List<PokemonModel> models =
          await repositorie.getPokemonDataByUrlAndName(pokemonGeneralData);
      return models;
    }
    return [];
  }
}
