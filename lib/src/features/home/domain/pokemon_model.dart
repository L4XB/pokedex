class PokemonModel {
  final String id;
  final String name;
  final String imageURL;
  final String type;
  final int weight;

  PokemonModel(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.type,
      required this.weight});
}
