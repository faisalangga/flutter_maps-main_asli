import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
  }) : super(key: key);

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hint;


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      hint: hint != null ? Text(hint!) : null,
    );
  }
}
