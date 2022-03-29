import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql/client.dart';
import 'package:organic/graphql/client.dart';

import '../../components/list_item_ad.dart';
import '../../components/shimmer_loading_list.dart';
import '../../models/ad.dart';
import '../../services/random_sad_image.dart';

class AdsScreen extends StatelessWidget {
  final Map<String, String> query;
  AdsScreen({this.query});
  final perform = Perform();

  final loadingData = ShimmerLoadingList();

  Future<QueryResult> GetAds(Map<String, String> query) async {
    const distance = 15.0;
    final Position currentPosition = await Geolocator.getCurrentPosition();
    if (query == null) {
      return perform.Find_Ads(
          currentPosition.latitude, currentPosition.longitude, distance);
    }
    switch (query['type']) {
      case 'category':
        return perform.Find_Ads_By_Category(currentPosition.latitude,
            currentPosition.longitude, distance, query['value']);
      case 'search':
        return perform.Find_Ads_By_Query(currentPosition.latitude,
            currentPosition.longitude, distance, query['value']);
      default:
        return perform.Find_Ads(
            currentPosition.latitude, currentPosition.longitude, distance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: FutureBuilder<QueryResult>(
            future: GetAds(query),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return loadingData;
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                          child: Image.asset(sadImage),
                        ),
                        const Text(
                          "Não foi encontrado nenhum resultado",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                      itemCount: adsList.length,
                      itemBuilder: (_, index) {
                        final Ad ad = adsList[index];
                        return ListItemAd(
                          ad: ad,
                        );
                      });
              }
              return Container();
            }),
      ),
    );
  }
}
