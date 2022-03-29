import 'package:flutter/material.dart';
import 'package:organic/graphql/client.dart';

class AboutUsScreen extends StatelessWidget {
  final Perform perform = Perform();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre Nós"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        children: const [
          Text(
            " Oi, nós somos o Organic!",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 32),
          Text(
            "Aqui o nosso objetivo é oferecer uma experiencia de compra e venda realmente especial. Nós acreditamos que é possível oferecer um serviço de alta qualidade a preços totalmente acessíveis, e é por isso que nos esforçamos tanto para tornar isso possível aqui.",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 32),
          Text(
            "Se você está atrás de uma experiência inovadora, então veio ao lugar certo. Venha descobrir uma nova maneira de comprar e vender!",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
