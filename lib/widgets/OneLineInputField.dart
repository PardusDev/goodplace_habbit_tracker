import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

class OneLineInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final IconButton? suffixIcon;
  const OneLineInputField({super.key, required this.hintText, this.controller, required this.obscureText, this.suffixIcon = null});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: context.general.textTheme.titleMedium!.copyWith(
          color: ColorConstants.loginScreenInputFieldTextColor,
          fontWeight: FontWeight.w300
      ),
      decoration: InputDecoration(
        fillColor: ColorConstants.loginScreenInputFieldBackgroundColor,
        filled: true,
        hintText: hintText,
        hintStyle: context.general.textTheme.titleMedium!.copyWith(
          color: ColorConstants.loginScreenInputFieldHintColor,
          fontWeight: FontWeight.w300
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: context.sized.dynamicWidth(0.06), vertical: context.sized.dynamicHeight(0.02)),
        border: const OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0))),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0))),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.transparent), borderRadius: BorderRadius.all(Radius.circular(15.0))),
        suffixIcon: suffixIcon,
      )
    );
  }
}
