import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> CategoriesItems() {
  final List<DropdownMenuItem<String>> _dropdownCategoriesList = [];
  final List<String> _categories = [
    "Legumes",
    "Verduras",
    "Frutas",
    "Mudas",
    "Hortaliças",
    "Grãos",
    "Sementes",
    "Especiarias",
    "Origem Animal",
    "Animais",
  ];
  _dropdownCategoriesList.add(
      const DropdownMenuItem(value: " ", child: Text("Não Especificar")));
  for (final String category in _categories) {
    _dropdownCategoriesList
        .add(DropdownMenuItem(value: category, child: Text(category)));
  }
  return _dropdownCategoriesList;
}

List<DropdownMenuItem<String>> MeasureItems() {
  final List<DropdownMenuItem<String>> _dropdownMeasuresList = [];
  _dropdownMeasuresList.add(
      const DropdownMenuItem(value: " ", child: Text("Não Especificar")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "Kg", child: Text("Quilo")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "g", child: Text("Grama")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "mg", child: Text("Miligrama")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "L", child: Text("Litro")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "ml", child: Text("Mililitro")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "Duzia", child: Text("Duzia")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "Unidade", child: Text("Unidade")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "Saco", child: Text("Saco")));
  _dropdownMeasuresList
      .add(const DropdownMenuItem(value: "Arroba", child: Text("Arroba")));
  return _dropdownMeasuresList;
}
