import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/icon_constants.dart';
import 'OneLineInputField.dart';

class OneLineInputFieldValidable extends StatefulWidget {
  final String hintText;
  final bool Function(String) validator;
  const OneLineInputFieldValidable({super.key, required this.hintText, required this.validator});

  @override
  State<OneLineInputFieldValidable> createState() => _OneLineInputFieldValidableState();
}

class _OneLineInputFieldValidableState extends State<OneLineInputFieldValidable> {
  bool _isValid = false;

  void _handleTextChanged(String text) {
    // TODO: This method will change according to state management
    setState(() {
      _isValid = widget.validator(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OneLineInputField(
      hintText: widget.hintText,
      suffixIcon: Icon(
          // TODO: Icon will change according to the design
          _isValid ? IconConstants.checkIcon : IconConstants.exclamationIcon,
          color: _isValid ? ColorConstants.validColor : ColorConstants.errorColor,
        ),
      obscureText: false,
      onChanged: _handleTextChanged,
    );
  }
}
