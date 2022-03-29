import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organic/models/ad.dart';

import '../../../routes.dart';

class BoostBottomSheet extends StatelessWidget {
  final Ad ad;

  const BoostBottomSheet({this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: Theme.of(context).accentColor),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        // gradient: LinearGradient(
        //   colors: [Color(0xF2009022), Color(0xFF32FF37)],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
      ),
      //color: Color(0xF2197D00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Que tal alcançar mais pessoas?",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.BOOST_AD_SCREEN,
                    arguments: ad);
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xF2009022),
                  padding: const EdgeInsets.all(6)),
              child: const Text(
                "Impulsionar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
        ],
      ),
    );
  }
}
