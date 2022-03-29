import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:organic/graphql/client.dart';
import 'package:provider/provider.dart';

import '../../../components/grid_item_ad.dart';
import '../../../components/shimmer_loading_grid.dart';
import '../../../models/ad.dart';
import '../../../services/user_manager.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  final carregandoDados = ShimmerLoadingGrid();

  final Perform perform = Perform();
  void Refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserManager userManager = Provider.of<UserManager>(context);
    return Container(
      margin: EdgeInsets.zero,
      child: FutureBuilder<QueryResult>(
          future: perform.Find_Ads_By_User(userManager.user.token),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return carregandoDados;
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError || snapshot.data.hasException) {
                  return const Text("Erro ao carregar os dados!");
                }
                final List<Ad> adsList = snapshot.data.data.values
                    .elementAt(1)
                    .map((ad) => Ad.fromMap(ad as Map<String, dynamic>))
                    .toList()
                    .cast<Ad>() as List<Ad>;
                if (adsList.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Você ainda não publicou nenhum anúncio",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: adsList.length,
                  itemBuilder: (_, index) {
                    return GridItemAd(
                      Refresh: Refresh,
                      ad: adsList[index],
                      onPressedRemove: () async {
                        if (await confirm(
                          context,
                          title: const Text('Excluir Anúncio'),
                          content: const Text(
                              'Tem certeza de que deseja excluir o Anúncio?'),
                          textOK: const Text('Excluir'),
                          textCancel: const Text('Cancelar'),
                        )) {
                          perform.Delete_Ad(
                                  adsList[index].id, userManager.user.token)
                              .then((value) => setState(() {}));
                        }
                      },
                    );
                  },
                );
            }
            return Container();
          }),
    );
  }
}
