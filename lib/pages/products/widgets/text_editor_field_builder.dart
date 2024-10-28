import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';

Widget buildTextEditorField({required String label}) {
  QuillController controller = QuillController.basic();

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
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.purple.shade50,
              child: QuillSimpleToolbar(
                controller: controller,
                configurations: const QuillSimpleToolbarConfigurations(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                children: [
                  QuillEditor.basic(
                    controller: controller,
                    configurations: const QuillEditorConfigurations(),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}
