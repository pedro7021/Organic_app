import 'package:flutter/material.dart';
import 'package:organic/screens/ads_screen/ads_screen.dart';

class SearchResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> query =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(title: const Text("Resultado")),
      body: AdsScreen(query: query),
    );
  }
}
