import 'dart:math';

List<String> _listaImagens = [
  "assets/sad images/abacate triste.png",
  "assets/sad images/abobora triste.png",
  "assets/sad images/brocolis triste.png",
  "assets/sad images/cenoura triste.png",
  "assets/sad images/tomate triste.png",
];
Random random = Random();

String get sadImage => _listaImagens[random.nextInt(5)];
