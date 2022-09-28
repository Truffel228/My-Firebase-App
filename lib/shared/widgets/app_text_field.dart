import 'package:fire_base_app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final OutlineInputBorder _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: stylePurpleColor,
    width: 2,
  ),
);

final OutlineInputBorder _errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: styleDarkRedColor,
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
    this.maxLines,
    this.minLines,
    this.enabled,
    this.initialValue,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        disabledBorder: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        errorBorder: _errorBorder,
        errorStyle:
            TextStyle(fontWeight: FontWeight.bold, color: styleDarkRedColor),
        focusedErrorBorder: _errorBorder,
      ),
    );
  }
}
