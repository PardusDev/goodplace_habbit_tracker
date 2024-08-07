import 'package:flutter/material.dart';

class TappableText extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;

  const TappableText({super.key, required this.onPressed, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
