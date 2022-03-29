import 'package:flutter/material.dart';

import '../../../components/button.dart';
import '../../../routes.dart';

class FrontLayerDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.LOGIN_SCREEN);
                  },
                  text: "Entre",
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "ou",
                    style: TextStyle(fontSize: 30),
                  ),
                ), //texto
                const SizedBox(height: 20),
                Button(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.SINGUP_SCREEN);
                  },
                  text: "Cadastre-se",
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "para publicar um anúncio",
                    style: TextStyle(fontSize: 30),
                  ),
                ), //para publicar um anuncio
              ],
            ),
          ),
        ),
      ),
    );
  }
}
