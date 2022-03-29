import 'package:flutter/material.dart';

import '../../../routes.dart';
import 'my_ads.dart';

class FrontLayerLogged extends StatefulWidget {
  @override
  _FrontLayerLoggedState createState() => _FrontLayerLoggedState();
}

class _FrontLayerLoggedState extends State<FrontLayerLogged> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.CREATE_AD_SCREEN)
                .then((value) => setState(() {}));
          },
          backgroundColor: Theme.of(context).primaryColor,
          label: const Text(
            "Novo Anúncio",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        body: MyAds());
  }
}
