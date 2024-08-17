import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class SortCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SortCard({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          isSelected ? ColorConstants.secondaryColor : ColorConstants.transparent,
        ),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: ColorConstants.secondaryColor, width: 2.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: ColorConstants.backButtonBorderColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}