import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/src/features/home/data/provider/pokemon_provider.dart';
import 'package:pokedex/src/features/home/domain/pokemon_model.dart';
import 'package:pokedex/src/features/home/presentation/widgets/pokemon_card.dart';
import 'package:pokedex/src/features/search/data/provider/search_provider.dart';
import 'package:pokedex/src/features/search/presentation/animated_search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pageSize = 20;
  bool _isSearchBarVisible = false;
  List<PokemonModel> _searchResults = [];

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

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
      if (!_isSearchBarVisible) {
        _searchResults = [];
      }
    });
  }

  void _updateSearchResults(List<PokemonModel> results) {
    setState(() {
      _searchResults = results;
    });
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
                  Visibility(
                    visible: !_isSearchBarVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        icon: const Icon(
                          Icons.search,
                          size: 28,
                        ),
                        onPressed: _toggleSearchBar,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: _searchResults.isEmpty
                    ? PagedGridView<int, PokemonModel>(
                        pagingController: _pagingController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        builderDelegate:
                            PagedChildBuilderDelegate<PokemonModel>(
                          itemBuilder: (context, item, index) => PokemonCard(
                            item: item,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return PokemonCard(
                            item: _searchResults[index],
                          );
                        },
                      ),
              ),
            ],
          ),
          Positioned(
            top: kToolbarHeight + 5,
            right: 11,
            child: AnimatedSearchBar(
              isVisible: _isSearchBarVisible,
              toggleVisibility: _toggleSearchBar,
              updateSearchResults: _updateSearchResults,
            ),
          ),
        ],
      ),
    );
  }
}
