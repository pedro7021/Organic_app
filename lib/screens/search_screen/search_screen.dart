import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import '../../components/grid_item_category.dart';
import '../../models/category.dart';
import '../../routes.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBar _searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('Pesquisar'),
        leading: _searchBar.getSearchAction(context));
  }

  _SearchScreenState() {
    _searchBar = SearchBar(
      hintText: "Pesquisar",
      inBar: false,
      setState: setState,
      onSubmitted: (str) {
        Navigator.pushNamed(context, AppRoutes.SEARCH_RESULT_SCREEN,
            arguments: {
              "value": str,
              "type": "search",
            });
      },
      buildDefaultAppBar: buildAppBar,
    );
  }

  final List<Category> Categories = [
    Category(title: 'Especiarias', image: 'assets/categories/Especiarias.jpg'),
    Category(title: 'Frutas', image: 'assets/categories/Frutas.jpg'),
    Category(title: 'Grãos', image: 'assets/categories/Grãos.jpg'),
    Category(title: 'Hortaliças', image: 'assets/categories/Hortaliças.jpg'),
    Category(title: 'Legumes', image: 'assets/categories/Legumes.jpg'),
    Category(title: 'Mudas', image: 'assets/categories/Mudas.jpg'),
    Category(title: 'Sementes', image: 'assets/categories/Sementes.jpg'),
    Category(title: 'Verduras', image: 'assets/categories/Verduras.jpg'),
    Category(
        title: 'Origem Animal', image: 'assets/categories/Origem Animal.jpg'),
    Category(title: 'Animais', image: 'assets/categories/Animais.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _searchBar.build(context),
        body: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
            ),
            itemCount: Categories.length,
            itemBuilder: (_, index) {
              return GridItemCategory(
                category: Categories[index],
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.SEARCH_RESULT_SCREEN,
                      arguments: {
                        "value": Categories[index].title,
                        "type": "category",
                      });
                },
              );
            }));
  }
}
