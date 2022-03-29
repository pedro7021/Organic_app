import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ad.dart';
import '../routes.dart';
import 'progress_box.dart';

class ListItemAd extends StatelessWidget {
  final Ad ad;
  final bool fakeBoosted;
  final bool disableClick;

  const ListItemAd({
    @required this.ad,
    this.fakeBoosted = false,
    this.disableClick = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => disableClick
          ? null
          : Navigator.pushNamed(
              context,
              AppRoutes.PRODUCT_SCREEN,
              arguments: [ad, false], //ad and isCreator
            ),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color: const Color(0xFFCBCBCB),
                          child: Image.network(
                            ad.images[0],
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return ProgressBox(
                                  loadingProgress: loadingProgress);
                            },
                          ),
                        ),
                      ),
                      if (fakeBoosted || ad.isBoosted)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                              ),
                              color: Colors.green.withOpacity(0.8),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "DESTAQUE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ad.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            "R\$ ${NumberFormat("#,##0.00").format(ad.price)} ${(ad.measure != null) ? ad.measure : ""}"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
