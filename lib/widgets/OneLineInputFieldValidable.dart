import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/icon_constants.dart';
import 'OneLineInputField.dart';

class OneLineInputFieldValidable extends StatefulWidget {
  final String hintText;
  final bool Function(String) onChanged;
  final TextEditingController controller;
  const OneLineInputFieldValidable({super.key, required this.hintText, required this.onChanged, required this.controller});

  @override
  State<OneLineInputFieldValidable> createState() => _OneLineInputFieldValidableState();
}

class _OneLineInputFieldValidableState extends State<OneLineInputFieldValidable> {
  bool _isValid = false;

  void _handleTextChanged(String text) {
    setState(() {
      _isValid = widget.onChanged(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OneLineInputField(
      hintText: widget.hintText,
      suffixIcon: Icon(
          _isValid ? IconConstants.checkIcon : IconConstants.exclamationIcon,
          color: _isValid ? ColorConstants.validColor : ColorConstants.errorColor,
        ),
      obscureText: false,
      onChanged: (String value) {
        _handleTextChanged(value);
        widget.onChanged;
      },
      controller: widget.controller,
    );
  }
}
