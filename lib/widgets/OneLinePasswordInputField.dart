import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputField.dart';
import 'package:kartal/kartal.dart';

import '../constants/icon_constants.dart';
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
    // TODO: implement initState
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    // TODO: This method will change according to state management
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
          ],
        )
        :
        visibilityIcon(),
    );
  }

  Widget visibilityIcon() {
    return IconButton(
      icon: Icon(
        // TODO: Icon will change according to the design
        _obscureText ? IconConstants.visibilityIcon : IconConstants.notVisibilityIcon,
      ),
      onPressed: _toggleObscureText,
    );
  }
}
