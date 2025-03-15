import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_sphere/core/utils/app_styles.dart';

class CustomAddBirthdate extends StatefulWidget {
  const CustomAddBirthdate({
    super.key,
    required this.onChanged,
  });
  final ValueChanged<DateTime> onChanged;
  @override
  State<CustomAddBirthdate> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomAddBirthdate> {
  DateTime? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: data,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));
        if (newDate != null) {
          setState(() {
            data = newDate;
            widget.onChanged(data ?? DateTime.now());
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          data == null
              ? "Add your Birth Date"
              : DateFormat.yMMMEd().format(data ?? DateTime.now()),
          style: AppStyles.text16Regular,
        ),
      ),
    );
  }
}
