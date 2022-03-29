import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerButton extends StatelessWidget {
  final void Function() onPressed;
  final Color baseColor;
  final Color highlightColor;
  final String text;
  static const double fontSize = 18;

  const ShimmerButton({
    @required this.onPressed,
    @required this.baseColor,
    @required this.highlightColor,
    @required this.text,
  });

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    final txtSize = _textSize(text, style);
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
              height: txtSize.height + 18,
              width: txtSize.width + 20,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
            ),
          ),
          Text(text, style: style),
        ],
      ),
    );
  }
}
