import 'package:flutter/material.dart';

Widget customTextFiled(
    {TextEditingController? controller,
    String? label = 'input',
    double padding = 8}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: TextField(
      decoration: InputDecoration(
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(padding)),
        contentPadding: const EdgeInsets.all(15),
        label: Text(label!),
      ),
      controller: controller,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      textCapitalization: TextCapitalization.sentences,
    ),
  );
}
