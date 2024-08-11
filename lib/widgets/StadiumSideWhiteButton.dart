import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'StadiumSideButton.dart';

class StadiumSideWhiteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const StadiumSideWhiteButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return StadiumSideButton(onPressed: onPressed, text: text, backgroundColor: ColorConstants.buttonWhiteBackground, textColor: ColorConstants.buttonWhiteTextColor);
  }
}
