import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

class ThanksScreen extends StatefulWidget {
  @override
  _ThanksScreenState createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _confettiController.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _degToRad(double deg) => deg * (pi / 180.0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(AppRoutes.NAVIGATION_SCREEN));
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Muito Obrigado"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Image.asset(
                "assets/tomate feliz.png",
              ),
            ),
            const Text(
              "Muito obrigado por depositar sua confiança em nós.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              "Espero que goste de nosso serviço e que continue conosco.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: _degToRad(290),
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  minBlastForce: 15,
                ),
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: _degToRad(240),
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  minBlastForce: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
