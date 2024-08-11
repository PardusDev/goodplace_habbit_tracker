import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputField.dart';
import 'package:kartal/kartal.dart';

import '../constants/string_constants.dart';

class OneLinePasswordInputField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextEditingController controller;
  const OneLinePasswordInputField({super.key, this.hintText = StringConstants.registerScreenPasswordHint, this.obscureText = true, this.suffixIcon = null, this.onChanged = null, required this.controller});


  @override
  State<OneLinePasswordInputField> createState() => _OneLinePasswordInputFieldState();
}

class _OneLinePasswordInputFieldState extends State<OneLinePasswordInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OneLineInputField(
        hintText: widget.hintText,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        suffixIcon:
        widget.suffixIcon != null ?
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.suffixIcon!,
            context.sized.emptySizedWidthBoxLow,
            visibilityIcon(),
            context.sized.emptySizedWidthBoxLow3x
          ],
        )
        :
        visibilityIcon(),
    );
  }

  Widget visibilityIcon() {
    return InkWell(
      onTap: _toggleObscureText,
      child: Image.asset(
        _obscureText ? ImageConstants.passwordHide : ImageConstants.passwordShown,
        width: context.sized.dynamicWidth(0.05),
        height: context.sized.dynamicHeight(0.05),
      ),
    );
  }
}
