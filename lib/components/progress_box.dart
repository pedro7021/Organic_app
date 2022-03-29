import 'package:flutter/material.dart';

class ProgressBox extends StatelessWidget {
  final ImageChunkEvent loadingProgress;

  const ProgressBox({@required this.loadingProgress});

  double percentage() {
    if (loadingProgress == null) {
      return 0;
    }
    return loadingProgress.expectedTotalBytes != null
        ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          color: const Color(0xFFCBCBCB),
        ),
        FractionallySizedBox(
          widthFactor: percentage(),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              //borderRadius: BorderRadius.circular(5),
            ),
          ),
        )
      ],
    );
  }
}
