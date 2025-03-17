import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;

  const CustomDropdown({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CustomDropdown> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Select Gender",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items:
          widget.categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
        widget.onCategorySelected(value!);
      },
    );
  }
}
