import 'package:flutter/material.dart';
import 'package:organic/screens/ads_screen/ads_screen.dart';

class InitScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Anúncios"),
        ),
        body: AdsScreen());
  }
}
