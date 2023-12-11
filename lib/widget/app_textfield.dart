import 'package:flutter/material.dart';
import 'package:koperasimobile/utils/utils_formatnumber.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType = TextInputType.text,
    required List<ThousandsFormatter> inputFormatters,
    required bool readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 10,
      controller: controller,
      keyboardType: inputType,
      inputFormatters: [ThousandsFormatter()],
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
        border: InputBorder.none,
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
    );
  }
}

