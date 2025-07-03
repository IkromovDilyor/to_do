import 'package:flutter/material.dart';
import 'package:to_do/utils/colors/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String hintText;
  final bool hasError;
  final int? maxLines;

  const CustomTextField({
    this.onChanged,
    this.hasError = false,
    this.hintText = "",
    this.controller,
    this.maxLines,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          maxLines:widget.maxLines ,

          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: AppColors.lightGrey,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.hasError ? AppColors.red : Colors.transparent,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.hasError ? AppColors.red : Colors.transparent,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: widget.hasError ? AppColors.red : Colors.blue,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
