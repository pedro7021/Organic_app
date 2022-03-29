import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductFloatingActionButton extends StatelessWidget {
  final int phoneNumber;

  const ProductFloatingActionButton({@required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    Future<void> _openContato(int number) async {
      final String url = "tel:$number";
      await launch(url);
    }

    Future<void> _openWhatsapp(int number) async {
      final String whatsappUrl =
          "whatsapp://send?phone=55$number&text=Olá, estou entrando em contato pelo seu anúncio no aplicativo Organic";
      await launch(whatsappUrl);
    }

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "btn2",
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(15.0))),
            onPressed: () async {
              await _openContato(phoneNumber);
            },
            label: const Text(
              "Contato ",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton.extended(
            heroTag: "btn3",
            backgroundColor: Colors.green,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(15.0))),
            onPressed: () async {
              await _openWhatsapp(phoneNumber);
            },
            label: const Text(
              "Whatsapp",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
