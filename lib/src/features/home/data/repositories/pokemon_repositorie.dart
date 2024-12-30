import 'package:dio/dio.dart';
import 'package:pokedex/src/features/home/domain/pokemon_general_informtion_model.dart';

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
}
