import 'package:flutter/material.dart';
import 'package:smart_farm_phone/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: SUB_COLOR,
        width: 0,
      ),
    );

    return TextFormField(
      cursorColor: WHITE_SUB_TEXT_COLOR,
      style: TextStyle(
        color: WHITE_TEXT_COLOR,
      ),
      autofocus: autofocus,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: WHITE_SUB_TEXT_COLOR,
          fontSize: 14,
        ),
        filled: true,
        fillColor: SUB_COLOR,
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: WHITE_SUB_TEXT_COLOR,
            width: 1,
          ),
        ),
      ),
    );
  }
}
