import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final OutlineInputBorder _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: purpleColor,
    width: 2,
  ),
);

final OutlineInputBorder _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: darkRedColor,
    width: 2,
  ),
);

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: _border,
        focusedBorder: _border,
        errorBorder: _errorBorder,
        errorStyle: TextStyle(fontWeight: FontWeight.bold, color: darkRedColor),
        focusedErrorBorder: _errorBorder,
      ),
    );
  }
}
