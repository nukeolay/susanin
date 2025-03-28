import 'package:flutter/material.dart';

class ValidatorTextField extends StatelessWidget {
  const ValidatorTextField({
    required this.controller,
    required this.isValid,
    required this.label,
    this.autofocus = false,
    this.onChanged,
    super.key,
  });
  final TextEditingController controller;
  final bool isValid;
  final String label;
  final bool autofocus;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: !isValid
            ? Icon(
                Icons.error_rounded,
                color: Theme.of(context).colorScheme.error,
              )
            : null,
        labelText: label,
        labelStyle: !isValid
            ? TextStyle(
                color: Theme.of(context).colorScheme.error,
              )
            : null,
      ),
      onChanged: onChanged,
    );
  }
}
