import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputField.dart';

class OneLinePasswordInputField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  const OneLinePasswordInputField({super.key, this.hintText = "Password", this.obscureText = true});


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
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleObscureText,
        ),
    );
  }
}
