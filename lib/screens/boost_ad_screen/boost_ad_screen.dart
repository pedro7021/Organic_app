import 'package:flutter/material.dart';
import 'package:organic/components/bottom_error_message.dart';
import 'package:organic/components/document_text.dart';
import 'package:organic/services/purchase_helper.dart';
import 'package:provider/provider.dart';

import '../../components/button.dart';
import '../../components/list_item_ad.dart';
import '../../models/ad.dart';
import '../../routes.dart';
import '../../services/user_manager.dart';

class BoostAdScreen extends StatefulWidget {
  @override
  _BoostAdScreenState createState() => _BoostAdScreenState();
}

class _BoostAdScreenState extends State<BoostAdScreen> {
  @override
  Widget build(BuildContext context) {
    final UserManager userManager = Provider.of<UserManager>(context);
    final BoostPurchase boostPurchase = Provider.of<BoostPurchase>(context);
    final Ad ad = ModalRoute.of(context).settings.arguments as Ad;
    final products = boostPurchase.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Impulsionar Anúncio"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Que tal ",
              style: const TextStyle(color: Colors.black, fontSize: 20),
              children: [
                TextSpan(
                  text: "Explodir",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor),
                ),
                const TextSpan(text: " o seu "),
                TextSpan(
                  text: "Negocio",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Conheça nossa opção de impulsionamento!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 26),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          const Text(
            "Oque é isso?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Impulsionamento é o serviço que nós oferecemos para que você venda ainda mais.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          const Text(
            "Então oque vai acontecer quando eu contratar?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Sempre no topo:",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          ),
          const SizedBox(height: 8),
          const Text(
            "Ao impulsionar o anúncio, o mesmo aparecerá sempre entre os primeiros da lista, tanto na página inicial quanto nas páginas de busca e categoria durante 7 dias.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Image.asset("assets/destaque.png"),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            "Selo:",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          ),
          const SizedBox(height: 8),
          const Text(
            "o anúncio fica visualmente destacado dos demais e ganha um selo de Destaque durante 7 dias, atraindo ainda mais compradores.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          ListItemAd(
            ad: ad,
            fakeBoosted: true,
            disableClick: true,
          ),
          const SizedBox(height: 14),
          const Divider(color: Colors.grey),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(width: 5, color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  "7 Dias",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "R\$ 9,99",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Divider(color: Colors.grey),
          const SizedBox(height: 14),
          Card(
            elevation: 10,
            child: ExpansionTile(
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              title: const Text(
                "Mais detalhes:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              children: [
                Topics([
                  const Text(
                      "O pagamento do impulsionamento é feito uma única vez pela loja de aplicativos do dispositivo, no momento da sua contratação, sem a ocorrência de renovação automática."),
                  const Text(
                      "Lembrando que o impulsionamento só será ativado quando o pagamento for aprovado."),
                  const Text(
                      "Vale sempre se atentar que são proibidos Produtos e Serviços ilegais no Organic caso seu anúncio seja identificado como ilegal, o mesmo será reportado para as autoridades competentes e será excluído."),
                  const Text(
                      "O impulsionamento permanece ativo pelo período contratado, porém ele é interrompido quando o anúncio é excluído pelo próprio usuário. Após a remoção do anúncio o impulsionamento não pode ser reativado."),
                  const Text(
                      "De acordo com nossos Termos de Uso, após a contratação do impulsionamento, quando concluído e ativado com sucesso, não é possível efetuar a devolução do valor pago ou transferir o impulsionamento de um anúncio para outro."),
                ], spaceBetween: true),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Button(
            onPressed: () async {
              // TODO boost ad screen
              boostPurchase.buy(
                product: products[0],
                ad: ad,
                token: userManager.user.token,
                onFail: (String e) {
                  BottomErrorMessage(context: context, errorMessage: e);
                },
                onSuccess: () {
                  Navigator.pushNamed(context, AppRoutes.THANKS_SCREEN);
                },
              );
            },
            text: "Impulsionar",
          ),
        ],
      ),
    );
  }
}
