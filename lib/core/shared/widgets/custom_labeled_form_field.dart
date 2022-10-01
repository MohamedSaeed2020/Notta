import 'package:flutter/material.dart';
import 'package:notes/core/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomLabeledFormField extends StatelessWidget {
  String? hintText;
  final String labelText;
  final int? maxLength;
  final int? maxLines;
  final TextInputType textInputType;
  final Widget? icon;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  IconData? suffix;
  bool isPassword = false;
  Function()? suffixPressed;
  bool enabled;

  CustomLabeledFormField({
    Key? key,
    this.hintText,
    required this.textInputType,
    this.icon,
    required this.controller,
    this.validate,
    this.maxLength,
    this.suffix,
    this.isPassword = false,
    this.suffixPressed,
    this.enabled = true,
    required this.labelText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 16,
      ),
      autofocus: false,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validate,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        errorMaxLines: 3,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Center(
                  child: Icon(
                    suffix,
                    size: 25,
                  ),
                ),
                onPressed: suffixPressed,
              )
            : null,
        contentPadding: const EdgeInsets.all(18),
        isDense: true,
        filled: true,
        fillColor: AppColors.whiteColor,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.hintTextColor,
          fontSize: 16,
        ),
        label: Text(
          labelText,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppColors.greyColor, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppColors.greyColor, width: 1),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: AppColors.greyColor, width: 1),
        ),
        icon: icon,
      ),
    );
  }
}
