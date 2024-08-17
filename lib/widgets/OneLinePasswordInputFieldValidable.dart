import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/icon_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLinePasswordInputField.dart';

import '../constants/color_constants.dart';

class OneLinePasswordInputFieldValidable extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool? isValid;

  const OneLinePasswordInputFieldValidable({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return OneLinePasswordInputField(
      hintText: hintText,
      suffixIcon: (isValid == null)
        ? null
        : Icon(
          isValid! ? IconConstants.checkIcon : IconConstants.exclamationIcon,
          color: isValid! ? ColorConstants.validColor : ColorConstants.errorColor,
      ),
      obscureText: true,
      onChanged: onChanged,
      controller: controller,
    );
  }
}
