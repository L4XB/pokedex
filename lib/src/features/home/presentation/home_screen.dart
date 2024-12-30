import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/src/features/home/data/provider/pokemon_provider.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pageSize = 20;

  final PagingController<int, PokemonModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await Provider.of<PokemonProvider>(context, listen: false)
              .getPokemons(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return const Color.fromARGB(149, 205, 61, 51);
      case 'water':
        return const Color.fromARGB(141, 78, 158, 224).withOpacity(0.7);
      case 'grass':
        return Colors.green.withOpacity(0.7);
      case 'electric':
        return Colors.yellow.withOpacity(0.7);
      // Weitere Typen hinzufügen
      default:
        return Colors.grey.withOpacity(0.7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
      ),
      body: PagedGridView<int, PokemonModel>(
        pagingController: _pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate<PokemonModel>(
          itemBuilder: (context, item, index) => Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: _getColorForType(item.type),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -15,
                right: -25,
                child: Image.network(
                  item.imageURL,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
