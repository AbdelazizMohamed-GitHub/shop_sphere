// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;
  final bool isUpdate;

  final String? productCategory;
  final String? text;

  const CustomDropdown({
    this.productCategory,
    this.text='Select Category',
    super.key,
    required this.categories,
    required this.onCategorySelected,
     this.isUpdate = false,
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
      value: widget.isUpdate ? widget.productCategory : selectedCategory,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText:
            widget.isUpdate
                ? widget.productCategory
                : selectedCategory ?? widget.text,
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
          selectedCategory = value;
        });
        widget.onCategorySelected(value!);
      },
    );
  }
}
