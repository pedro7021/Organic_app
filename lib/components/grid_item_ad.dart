import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ad.dart';
import '../routes.dart';
import 'progress_box.dart';

class GridItemAd extends StatelessWidget {
  final Ad ad;
  final VoidCallback onPressedRemove;
  final Function Refresh;
  const GridItemAd({
    @required this.ad,
    @required this.onPressedRemove,
    @required this.Refresh,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.PRODUCT_SCREEN,
        arguments: [ad, true], //ad and isCreator
      ).then((value) => Refresh()),
      child: Card(
        elevation: 6,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Container(
                      color: const Color(0xFFCBCBCB),
                      child: AspectRatio(
                        aspectRatio: 1,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: onPressedRemove,
                      ),
                    ),
                    if (ad.isBoosted)
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
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ad.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "R\$ ${NumberFormat("#,##0.00").format(ad.price)} ${ad.measure}",
                overflow: TextOverflow.fade,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
