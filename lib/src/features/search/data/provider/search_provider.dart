import 'package:flutter/material.dart';
import 'package:pokedex/src/features/home/data/repositories/pokemon_repositorie.dart';
import 'package:pokedex/src/features/home/domain/pokemon_general_informtion_model.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';

class SearchProvider extends ChangeNotifier {
  PokemonRepositorie repositorie = PokemonRepositorie();
  List<PokemonGeneralInformtionModel> generalPokemonInformations = [];

  Future<void> initialize() async {
    await _loadAllGeneralPokemonInfomrations();
    notifyListeners();
  }

  Future<void> _loadAllGeneralPokemonInfomrations() async {
    generalPokemonInformations = await repositorie
            .getPokemonGeneralInfomrationsWithLimitAndOffset(1500, 0) ??
        [];
    notifyListeners();
  }

  Future<List<PokemonModel>> searchPokemons(String query) async {
    // Implementiere hier die Suchlogik
    return [];
  }
}