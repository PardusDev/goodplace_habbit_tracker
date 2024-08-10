import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StadiumSideButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const StadiumSideButton({super.key, required this.onPressed, required this.text, required this.backgroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.sized.dynamicHeight(0.06),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sized.dynamicHeight(0.06)),
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: context.general.textTheme.titleSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
