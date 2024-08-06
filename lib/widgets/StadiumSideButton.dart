import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../constants/color_constants.dart';

class StadiumSideButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const StadiumSideButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.sized.dynamicHeight(0.06),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.buttonWhiteBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sized.dynamicHeight(0.06)),
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: context.general.textTheme.titleSmall?.copyWith(
              color: ColorConstants.buttonWhiteTextColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
