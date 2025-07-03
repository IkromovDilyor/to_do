import 'package:flutter/material.dart';
import 'package:to_do/utils/colors/app_colors.dart';
import 'package:to_do/utils/theme/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final EdgeInsets margin;
  final bool isDisabled;
  final bool isLoading;

  CustomButton({
    this.margin = EdgeInsets.zero,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onTap,
    this.text = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: isLoading || isDisabled ? AppColors.lightGrey : AppColors.primary),
        onPressed: isLoading || isDisabled ? null : onTap,
        child: Center(
          child:
          isLoading
              ? CircularProgressIndicator(color: AppColors.primary)
              : Text(
            text,
            style: AppTextStyle.size16Weight600.copyWith(color: isDisabled ? AppColors.secondaryText : AppColors.white),
          ),
        ),
      ),
    );
  }
}
