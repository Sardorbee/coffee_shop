import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  const CustomSmallButton(
      {super.key, required this.iconData, required this.onTap});
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height * 0.04,
        width: height * 0.04,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(8)),
        child: Icon(iconData),
      ),
    );
  }
}
