import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final void Function(String) onSaved;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final String Function(String) validator;
  final TextEditingController controller;
  final bool enabled;
  final bool autocorrect;
  final bool obscureText;
  final int maxLength;

  const CustomTextField({
    @required this.title,
    @required this.hintText,
    this.onSaved,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.enabled = true,
    this.autocorrect = true,
    this.obscureText = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextFormField(
          maxLines: obscureText ? 1 : null,
          maxLength: maxLength,
          enabled: enabled,
          autocorrect: autocorrect,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
