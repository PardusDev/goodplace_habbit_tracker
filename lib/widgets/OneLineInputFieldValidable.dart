import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/icon_constants.dart';
import 'OneLineInputField.dart';

class OneLineInputFieldValidable extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;
  final bool? isValid;
  const OneLineInputFieldValidable({super.key, required this.hintText, required this.onChanged, required this.controller, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return OneLineInputField(
      hintText: hintText,
      suffixIcon: isValid == null
      ? null
      : Icon(
        isValid! ? IconConstants.checkIcon : IconConstants.exclamationIcon,
        color: isValid! ? ColorConstants.validColor : ColorConstants.errorColor,
      ),
      obscureText: false,
      onChanged: onChanged,
      controller: controller,
    );
  }
}
