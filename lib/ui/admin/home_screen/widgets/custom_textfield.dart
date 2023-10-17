import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      required this.inputType,
      this.maxLines});

  final String hintText;
  final ValueChanged onChanged;
  final TextInputType inputType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      keyboardType: inputType,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: AppColors.itemColor,
      ),
      style: const TextStyle(color: AppColors.buttonColor),
    );
  }
}
