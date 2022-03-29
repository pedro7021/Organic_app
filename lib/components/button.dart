import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const Button({
    @required this.onPressed,
    @required this.text,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => isLoading ? null : onPressed(),
      style: ElevatedButton.styleFrom(
        primary: (backgroundColor != null)
            ? backgroundColor
            : Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                  color: (textColor != null) ? textColor : Colors.white,
                  fontSize: 24,
                ),
              ),
      ),
    );
  }
}
