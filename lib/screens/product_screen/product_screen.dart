import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organic/screens/product_screen/components/boost_bottom_sheet.dart';
import 'package:organic/screens/product_screen/components/product_floating_action_button.dart';

import '../../models/ad.dart';
import '../../routes.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as List;
    final Ad _ad = arguments[0] as Ad;
    final bool isCreator = arguments[1] as bool;

    return Scaffold(
      appBar: AppBar(title: const Text("Anúncio")),
      // bottomSheet:
      //     (isCreator && !_ad.isBoosted) ? BoostBottomSheet(ad: _ad) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !isCreator
          ? ProductFloatingActionButton(phoneNumber: _ad.phone)
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                    dotSize: 4,
                    dotSpacing: 15,
                    dotBgColor: Colors.transparent,
                    dotColor: Theme.of(context).primaryColor,
                    autoplay: false,
                    images: _ad.images.map<Widget>((imagem) {
                      return Image.network(
                        imagem,
                      );
                    }).toList()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (isCreator && !_ad.isBoosted) BoostBottomSheet(ad: _ad),
                  Text(
                    _ad.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "R\$ ${NumberFormat("#,##0.00").format(_ad.price)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (_ad.measure != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          _ad.measure,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        )
                      ] else
                        Container()
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    _ad.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.grey,
                  ),
                  if (!isCreator)
                    Row(
                      children: [
                        const Text(
                          "Irregularidades no anúncio?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.DENUNCIATE_SCREEN,
                                arguments: _ad);
                          },
                          child: const Text(
                            "Denunciar",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 70)
          ],
        ),
      ),
    );
  }
}
