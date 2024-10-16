import 'package:flutter/material.dart';

Widget buildFormField({
  required String label,
  required String? Function(String?) validator,
  String? hintText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      TextFormField(
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      )
    ],
  );
}
