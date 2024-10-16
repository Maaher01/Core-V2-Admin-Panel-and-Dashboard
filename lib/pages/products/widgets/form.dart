import 'package:flutter/material.dart';
import '../widgets/formfield_builder.dart';
import '../widgets/dropdown_menu.dart';
import '../widgets/text_editor_field_builder.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

class CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFormField(
            label: 'Product Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Product Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFormField(
                label: 'Unit Price',
                hintText: 'Ex: 1000',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Unit Price is required';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          buildTextEditorField(label: 'Description'),
          const SizedBox(height: 24.0),
          const CustomDropdownMenu(),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Publish Now'),
            ),
          ),
        ],
      ),
    );
  }
}
