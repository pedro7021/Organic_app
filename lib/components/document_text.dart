import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottom_error_message.dart';

Widget Strong(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  );
}

Widget WebLink({
  @required BuildContext context,
  @required String text,
  @required String url,
}) {
  return RichText(
      text: TextSpan(
    text: text,
    style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
    recognizer: TapGestureRecognizer()
      ..onTap = () async {
        try {
          await launch(url);
        } catch (e) {
          BottomErrorMessage(
              errorMessage: "Não foi possível abrir o Link", context: context);
        }
      },
  ));
}

Widget Topics(List<Widget> topicos, {bool spaceBetween = false}) {
  return Column(
      children: topicos
          .map(
            (topico) => Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, spaceBetween ? 8 : 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(12, 6, 2, 0),
                    width: 7.0,
                    height: 7.0,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    // child:  topico,
                  ),
                  Expanded(
                    child: topico,
                  ),
                ],
              ),
            ),
          )
          .toList());
}

Widget Usual(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 16),
  );
}
