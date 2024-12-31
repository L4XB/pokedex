import 'package:dio/dio.dart';
import 'package:pokedex/src/common/utils/utils.dart';
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
    Utils utils = Utils();
    for (var model in models) {
      final Response response;
      response = await Dio().get(model.url);
      try {
        if (response.statusCode == 200 || response.statusCode == 201) {
          String id =
              utils.transformIdToRightFormat(response.data["id"].toString());
          String name =
              utils.transformTextToRightShape(response.data["name"].toString());
          String imageURL = response.data["sprites"]["other"]["home"]
                  ["front_default"]
              .toString();

          List<String> types = [];
          for (var element in response.data["types"]) {
            types.add(utils
                .transformTextToRightShape(element["type"]["name"].toString()));
          }

          int weight = response.data["weight"];
          PokemonModel model = PokemonModel(
              id: id,
              name: name,
              imageURL: imageURL,
              types: types,
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
