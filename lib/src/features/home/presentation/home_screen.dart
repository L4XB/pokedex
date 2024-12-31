import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/src/features/home/data/provider/pokemon_provider.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:pokedex/src/features/home/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/src/features/search/data/provider/search_provider.dart';
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
    _initSearchProvider();
  }

  Future<void> _initSearchProvider() async {
    await Provider.of<SearchProvider>(context, listen: false).initialize();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -37,
            left: 233,
            child: Image.asset(
              "assets/pokeball_background_image.png",
              fit: BoxFit.contain,
              color: const Color.fromARGB(255, 227, 227, 227).withOpacity(0.5),
              height: 250,
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text(
                  'Pokédex',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                      ),
                      onPressed: () {
                        // Handle menu button press
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PagedGridView<int, PokemonModel>(
                  pagingController: _pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<PokemonModel>(
                    itemBuilder: (context, item, index) => PokemonCard(
                      item: item,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
