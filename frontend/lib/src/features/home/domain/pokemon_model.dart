class PokemonModel {
  final String id;
  final String name;
  final String imageURL;
  final List<String> types;
  final int weight;

  PokemonModel(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.types,
      required this.weight});
}
