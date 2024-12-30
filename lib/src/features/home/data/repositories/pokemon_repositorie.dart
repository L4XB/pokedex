import 'package:dio/dio.dart';
import 'package:pokedex/src/features/home/domain/pokemon_general_informtion_model.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';

class PokemonRepositorie {
  Future<List<PokemonGeneralInformtionModel>?>
      getPokemonGeneralInfomrationsWithLimitAndOffset(
          int limit, int offset) async {
    final Response response;

    response = await Dio()
        .get("https://pokeapi.co/api/v2/pokemon/?limit=$limit&offset=$offset");

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<PokemonGeneralInformtionModel> poekmonDataModels = [];
      for (dynamic element in response.data["results"]) {
        PokemonGeneralInformtionModel model = PokemonGeneralInformtionModel(
            name: element["name"], url: element["url"]);
        poekmonDataModels.add(model);
      }

      return poekmonDataModels;
    } else {
      return null;
    }
  }

  Future<List<PokemonModel>> getPokemonDataByUrlAndName(
      List<PokemonGeneralInformtionModel> models) async {
    List<PokemonModel> pokemonModelsWithData = [];
    for (var model in models) {
      final Response response;
      response = await Dio().get(model.url);
      try {
        if (response.statusCode == 200 || response.statusCode == 201) {
          String id = response.data["order"].toString();
          String name = response.data["name"].toString();
          String imageURL = response.data["sprites"]["back_default"].toString();
          String type = response.data["types"][0]["type"]["name"].toString();
          int weight = response.data["weight"];
          PokemonModel model = PokemonModel(
              id: id,
              name: name,
              imageURL: imageURL,
              type: type,
              weight: weight);
          pokemonModelsWithData.add(model);
        }
      } catch (e) {
        print(e);
      }
    }

    return pokemonModelsWithData;
  }
}
