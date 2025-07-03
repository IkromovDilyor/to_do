import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/utils/colors/app_colors.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback? onTap;

  const CustomCheckBox({this.onTap,required this.isChecked, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isChecked ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(11.5),
          border: Border.all(
            color: isChecked ? AppColors.primary : AppColors.blueGray,
            width: 3,
          ),
        ),
        child: Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: isChecked ? AppColors.white : Colors.transparent,
        ),
      ),
    );
  }
}
