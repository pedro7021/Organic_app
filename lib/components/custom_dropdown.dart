import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final String hintText;
  final List<DropdownMenuItem<dynamic>> items;
  final void Function(dynamic) onChanged;
  final void Function(dynamic) onSaved;
  final String Function(dynamic) validator;

  const CustomDropdown({
    @required this.title,
    @required this.hintText,
    @required this.items,
    @required this.onSaved,
    this.onChanged,
    this.validator,
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
        DropdownButtonFormField(
          elevation: 6,
          hint: Text(hintText, overflow: TextOverflow.fade, maxLines: 1),
          items: items,
          onChanged: (onChanged != null) ? onChanged : (str) {},
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }
}
