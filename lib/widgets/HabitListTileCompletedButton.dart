import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class HabitListTileCompletedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  const HabitListTileCompletedButton({super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.homePageCompletedHabitListTileButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(buttonText, style: const TextStyle(color: ColorConstants.homePageCompletedHabitListTileButtonTextColor)),
    );
  }
}
