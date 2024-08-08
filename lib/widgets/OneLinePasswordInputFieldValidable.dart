import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/icon_constants.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLinePasswordInputField.dart';

import '../constants/color_constants.dart';

class OneLinePasswordInputFieldValidable extends StatefulWidget {
  final String hintText;
  final bool Function(String) validator;
  const OneLinePasswordInputFieldValidable({super.key, required this.hintText, required this.validator});

  @override
  State<OneLinePasswordInputFieldValidable> createState() => _OneLinePasswordInputFieldValidableState();
}

class _OneLinePasswordInputFieldValidableState extends State<OneLinePasswordInputFieldValidable> {
  bool _isValid = false;

  void _handleTextChanged(String text) {
    // TODO: This method will change according to state management
    setState(() {
      _isValid = widget.validator(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OneLinePasswordInputField(
      hintText: StringConstants.registerScreenPasswordHint,
      suffixIcon: Icon(
        // TODO: Icon will change according to the design
        _isValid ? IconConstants.checkIcon : IconConstants.exclamationIcon,
        color: _isValid ? ColorConstants.validColor : ColorConstants.errorColor,
      ),
      obscureText: true,
      onChanged: _handleTextChanged,
    );
  }
}
